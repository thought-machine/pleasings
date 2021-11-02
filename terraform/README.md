Terraform build rules
=====================

These build defs contain a set of rules for using Terraform configuration with plz. 

This includes support for the following:
 * `terraform_toolchain`: Multiple versions of Terraform.
 * `terraform_provider`: Terraform provider caching.
 * `terraform_module`: Terraform remote and local modules.
 * `terraform_root`: Teraform root modules for `plan`ning, `apply`ing, etc.

## `terraform_toolchain`

This build rule allows you to specify a Terraform version to download and re-use in `terraform_root` rules. You can repeat this for multiple versions if you like, see `//third_party/terraform/BUILD` for examples.

## `terraform_provider`

The use of this feature is **optional**. **Note**: It is unstable in Terraform 0.14+ due to the [Terraform dependency lock file](https://www.terraform.io/docs/language/dependency-lock.html).

This build rule allows you to specify a Terraform provider to download and **cache** with `terraform_root` rules via the `providers` parameter. Any referenced `providers` will populate and configure a [Terraform provider cache](https://www.terraform.io/docs/cli/config/config-file.html#provider-plugin-cache) for Terraform to use with that `terraform_root`. 

## `terraform_module`

This build rule allows you to specify a [Terraform module](https://www.terraform.io/docs/language/modules/index.html) to re-use in your `terraform_root` rules or as dependencies in other `terraform_module` rules. Terraform modules can be sourced remotely or exist locally on the filesystem. 

See `//third_party/terraform/module/BUILD` for examples of remote Terraform modules.
See `//terraform/examples/<version>/my_module/BUILD` for examples of local terraform modules.

In your Terraform source code, you should refer to your modules by their **canonical** build label. e.g.:

```
module "remote_module" {
    source = "//third_party/terraform/module:a_module"
}

module "my_module" {
    source = "//terraform/examples/0.12/my_module:my_module"
}
``` 

## `terraform_root`

This build rule allows to specify a [Terraform root module](https://www.terraform.io/docs/language/modules/index.html#the-root-module) which is the root configuration where Terraform will be executed. In this build rule, you reference the `srcs` for the root module as well as optionally (but recommended) the `modules` those `srcs` use.

We support substitution of the following please build environment variables into your source terraform files:
 - `PKG`
 - `PKG_DIR`
 - `NAME`
 - `ARCH`
 - `OS` 
This allows you to template Terraform code to keep your code DRY. for example: A terraform remote state configuration can that can be re-used in all `terraform_root`s:
```
terraform {
  backend "s3" {
    region         = "eu-west-1"
    bucket         = "my-terraform-state"
    key            = "$PKG/$NAME.tfstate"
    dynamodb_table = "my-terraform-state-lock"
    encrypt        = true
  }
}
```
The above will result in a terraform state tree consistent with the structure of your repository.

This build rule takes arbitrary input as commands to run within the Root module's workspace. For example:
```
plz run //my_infrastructure_tf_workspace -- "terraform init && terraform console"
```

It also generates the following default subrules which perform the Terraform workflows:
 * `_plan`: `terraform init && terraform plan $@`
 * `_apply`: `terraform init && terraform apply $@`
 * `_destroy`: `terraform init && terraform destroy $@`
 * `_validate`: `terraform init -backend=false && terraform validate $@`

For all of these workflows, we support passing in flags via please, e.g.:
```
$ plz run //my_tf:my_tf_plan -- -lock=false
$ plz run //my_tf:my_tf_apply -- --target resource_type.my_resource
```

### Overriding the default subrules

If you'd like to override the default subrules (`_plan`, `_apply`, `_destroy`, `_validate`) to include other commands or flags, e.g. add flags `terraform init -lock=false`, you can override the `terraform_root` build rule and set `add_default_workflows = False` to the `terraform_root`. An example is below:

```python
# //build/defs/terraform.build_defs
subinclude("//third_party/defs:terraform")
_upstream_terraform_root = terraform_root

def terraform_root(
    name: str,
    srcs: list,
    var_files: list = [],
    modules: list = [],
    providers: list = [],
    toolchain: str = None,
    labels: list = [],
    visibility: list = [],
): 
    terraform_workspace = _upstream_terraform_root(
      name=name, 
      srcs=srcs, 
      var_files=var_files, 
      modules=modules, 
      providers=providers, 
      toolchain=toolchain, 
      labels=labels, 
      visbility=visibility,
      add_default_workflows=False,
    )
    workflows = {
        "plan": "terraform init <ARGS> && terraform plan",
        "apply": "terraform init <ARGS> && terraform apply",
    }

    for workflow in workflows.keys():
        cmd = workflows[workflow]

        sh_cmd(
            name = f"{name}_{workflow}",
            shell = "/usr/bin/env bash",
            data = [terraform_workspace],
            cmd = f"$(out_exe {terraform_workspace}) \"{cmd} \\\$@\"",
            labels = [f"terraform_{workflow}"],
        )
```

See `//terraform/examples/<version>/BUILD` for examples of `terraform_root`. 

**NOTE**: This build rule utilises a [Terraform working directory](https://www.terraform.io/docs/cli/init/index.html) in `$TMPDIR` (`/tmp` by default), so whilst this is okay for demonstrations, you must use [Terraform Remote State](https://www.terraform.io/docs/language/state/remote.html) for your regular work. 

---

## Usage

To use this build_def in your repository, you will need multiple files:
```python
# //third_party/defs/BUILD

# pick the latest commit
TERRAFORM_DEF_VERSION = "750b9ecbf9f7cf1ed8a63eb6c4f261c3223e8004"

remote_file(
    name = "terraform",
    url = f"https://raw.githubusercontent.com/thought-machine/pleasings/{TERRAFORM_DEF_VERSION}/terraform/terraform.build_defs",
    hashes = ["4d4aabff148f46610668725be989d2c8c20990741cff9b6c8575d5d530be004a"],
    visibility = ["PUBLIC"],
)

remote_file(
    name = "terraform_tool",
    url = f"https://raw.githubusercontent.com/thought-machine/pleasings/{TERRAFORM_DEF_VERSION}/terraform/scripts/terraform.sh",
    hashes = ["c7af1cebd9bc6345103fb71a8f933ecbb9b7026cb2aed43f98ed3e2c5da79559"],
    visibility = ["PUBLIC"],
    binary = True,
)
```

```ini
# .plzconfig

[buildconfig]
terraform-plz-tool = //third_party/defs:terraform_tool
```

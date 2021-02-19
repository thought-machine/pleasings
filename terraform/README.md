Terraform build rules
=====================

These build defs contain a set of rules for using Terraform configuration with plz. 

This includes support for the following:
 * `terraform_provider`: Terraform Providers
 * `terraform_module`: Terraform Remote Modules
 * `terraform_module`: Terraform Local Modules
 * `terraform_toolchain`: Multiple versions of Terraform
 * Terraform fmt/validate


## `terraform_toolchain`

This build rule allows you to specify a Terraform version to download and re-use in `terraform_root` rules. You can repeat this for multiple versions if you like, see `//third_party/terraform/BUILD` for examples.

## `terraform_provider`

This build rule allows you to specify a [Terraform provider](https://www.terraform.io/docs/providers/index.html) to re-use in your `terraform_root` rules. See `//third_party/terraform/provider/BUILD` for examples.

## `terraform_module`

This build rule allows you to specify a [Terraform module](https://www.terraform.io/docs/language/modules/index.html) to re-use in your `terraform_root` rules or as dependencies in other `terraform_module` rules. Terraform modules can be sourced remotely or exist locally on the filesystem. 

See `//third_party/terraform/module/BUILD` for examples of remote Terraform modules.
See `//terraform/examples/<version>/my_module/BUILD` for examples of local terraform modules.

In your Terraform source code, you should refer to your modules by their canonical build label. e.g.:

```
module "remote_module" {
    source = "//third_party/terraform/module:a_module"
}

module "my_module" {
    source = "//terraform/examples/0.12/my_module:my_module"
}
``` 

## `terraform_root`

This build rule allows to specify a [Terraform root module](https://www.terraform.io/docs/language/modules/index.html#the-root-module) which is the root configuration where Terraform will be executed. In this build rule, you reference the `srcs` for the root module as well as optionally (but recommended) the providers and modules those `srcs` use. This is optional as we cannot disable the pulling of providers and modules in Terraform 0.13+, so we only pre-populate the Terraform cache. However, it is advisable to use these parameters to reduce network load so that providers and modules are only downloaded once.

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

This build rule generates the following subrules which perform the Terraform workflows:
 * `terraform init`
 * `terraform console`
 * `terraform graph`
 * `terraform import`
 * `terraform output`
 * `terraform providers`
 * `terraform taint`
 * `terraform untaint`
 * `terraform plan`
 * `terraform apply`
 * `terraform destroy`

For all of these workflows, we support passing in flags via please as expected, e.g.:
```
$ plz run //my_tf:my_tf_plan -- -lock=false
$ plz run //my_tf:my_tf_import -- resource_type.my_resource resource_id
```

We also add an environment variable `TF_CLEAN_OUTPUT` which strips noisy Terraform output on a best effort basis. This is incompatible with interactive commands, so we only advise setting this in automation.


It additionally adds linters under the `lint` label for:
* `terraform fmt -check`
* `terraform validate`

See `//terraform/examples/<version>/BUILD` for examples of `terraform_root`. 

**NOTE**: This build rule utilises a [Terraform working directory](https://www.terraform.io/docs/cli/init/index.html) in `plz-out`, so whilst this is okay for demonstrations, you must use [Terraform Remote State](https://www.terraform.io/docs/language/state/remote.html) for your regular work. This can be added either simply through your `srcs` or through a `pre_binaries` binary.

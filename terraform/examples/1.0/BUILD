subinclude("//terraform")

terraform_root(
    name = "example",
    srcs = ["main.tf", "variables.tf"],
    toolchain = "//third_party/terraform:terraform_1_0",
    modules = [
        "//third_party/terraform/module:cloudposse_null_label_0_12",
        "//terraform/examples/1.0/my_module:my_module",
    ],
    providers = [
        "//third_party/terraform/provider:null",
    ],
    var_files = ["my_vars.tfvars"],
)

subinclude("//terraform")

terraform_root(
    name = "example",
    srcs = [
        "main.tf", 
        "data.tf",
        "variables.tf",
    ],
    toolchain = "//third_party/terraform:terraform_0_11",
    modules = [
        "//third_party/terraform/module:cloudposse_null_label_0_11",
        "//terraform/examples/0.11/my_module:my_module",
    ],
    providers = [
        "//third_party/terraform/provider:null",
    ],
    var_files = ["my_vars.tfvars"],

)

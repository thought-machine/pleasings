subinclude("//terraform")

terraform_root(
    name = "example",
    srcs = ["main.tf"],
    toolchain = "//third_party/terraform:terraform_0_12",
    providers = [
        "//third_party/terraform/provider:null",
    ],
    modules = [
        "//third_party/terraform/module:cloudposse_null_label_0_12",
        "//terraform/examples/0.12/my_module:my_module",
    ]
)

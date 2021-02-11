subinclude("//terraform")

terraform(
    name = "example",
    srcs = ["main.tf"],
    toolchain = "//third_party/terraform:terraform_0_14",
    providers = [
        "//third_party/terraform/provider:null",
    ],
    modules = [
        "//third_party/terraform/module:cloudposse_null_label_0_12",
        "//terraform/examples/0.14/my_module:my_module",
    ]
)

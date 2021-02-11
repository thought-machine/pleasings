subinclude("//terraform")

terraform(
    name = "example",
    srcs = ["main.tf"],
    toolchain = "//third_party/terraform:terraform_0_13",
    providers = [
        "//third_party/terraform/provider:null",
    ],
    modules = [
        "//third_party/terraform/module:cloudposse_null_label_0_12",
        "//terraform/examples/0.13/my_module:my_module",
    ]
)

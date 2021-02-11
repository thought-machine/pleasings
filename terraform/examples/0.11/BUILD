subinclude("//terraform")

terraform_root(
    name = "example",
    srcs = ["main.tf", "data.tf"],
    toolchain = "//third_party/terraform:terraform_0_11",
    providers = [
        "//third_party/terraform/provider:null",
    ],
    modules = [
        "//third_party/terraform/module:cloudposse_null_label_0_11",
        "//terraform/examples/0.11/my_module:my_module",
    ]
)

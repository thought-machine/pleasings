subinclude("//terraform")

terraform_module(
    name = "my_module",
    srcs = ["main.tf"],
    deps = [
        "//third_party/terraform/module:cloudposse_null_label_0_12",
    ],
    visibility = ["//terraform/examples/0.14/..."],
)

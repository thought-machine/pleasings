subinclude("//k8s")

k8s_config(
    name = "example",
    srcs = [
        "example.yaml",
        "example-svc.yaml",
    ],
    containers = ["//docker/example:image"],
)

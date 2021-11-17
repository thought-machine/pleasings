subinclude("//k8s")

k8s_config(
    name = "example",
    srcs = [
        "example.yaml",
        "example-svc.yaml",
    ],
    params = {
        'EXAMPLE_PARAM' : 'test',
    },
    containers = ["//docker/example:image"],
)

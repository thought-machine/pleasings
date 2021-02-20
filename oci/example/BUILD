subinclude("//oci")

python_binary(
    name = "example",
    main = "example.py",
)

oci_image(
    name = "base",
    containerfile = 'Dockerfile-base',
)

oci_image(
    name = "image",
    srcs = [":example"],
    base_image = ":base",
    run_args = "",
    visibility = ["//k8s/example:all"],
)

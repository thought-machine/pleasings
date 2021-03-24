subinclude("//oci")

python_binary(
    name = "example",
    main = "example.py",
)

# demonstrating backwards compatibility,
container_image(
    name = "docker_style_base",
    dockerfile = "Dockerfile-base",
    visibility = ['PUBLIC']
)
# although you do have to specify a dockerfile explicitly, as it is no longer always required.
container_image(
    name = "docker_style_image",
    srcs = [":example"],
    dockerfile = "Dockerfile",
    base_image = ":docker_style_base",
    visibility = ["//k8s/example:all"],
)

# demonstrating transitive_base_images
# pointless intermediate image as an example
container_image(
    name = "intermediate_image",
    base_image = ':docker_style_base',
)
container_image(
    name = "multiple_base_image",
    srcs = [":example"],
    base_image = ":intermediate_image",
    transitive_base_images = [':docker_style_base'],
    visibility = ["//k8s/example:all"],
)

# demonstrating use of distroless images
container_image(
    name = "python_distroless",
    base_image = 'gcr.io/distroless/python3@sha256:72684cdc6e9405189ad24356248950f5480b02db35ab59dfee9f849769feec33',
)
# notice no containerfile or cmd/entrypoint required
container_image(
    name = "distroless_image",
    srcs = [":example"],
    base_image = ":python_distroless",
    visibility = ["//k8s/example:all"],
)

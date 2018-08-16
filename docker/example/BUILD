subinclude("//docker")

python_binary(
    name = "example",
    main = "example.py",
)

docker_image(
    name = "base",
    dockerfile = "Dockerfile-base",
)

docker_image(
    name = "image",
    srcs = [":example"],
    base_image = ":base",
    run_args = "-p 8000:8000",
)

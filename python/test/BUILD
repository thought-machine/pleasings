subinclude("//python:requirements")

requirements_txt(
    name = "requirements",
)

python_test(
    name = "requirements_test",
    srcs = ["requirements_test.py"],
    deps = [":requirements"],
)

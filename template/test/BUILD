subinclude("//template:template")

template_files(
    name = "generated_files",
    srcs = ["templated.yaml"],
    substitutions = [
        "//template/test/single_line",
        ":single_line_local",
        "//template/test/concatenated",
    ],
    outs = ["generated.py"],
    visibility = ["//template/test/..."],
)

python_test(
    name = "template_test",
    srcs = ["template_test.py"],
    deps = [":template_files",
            ":generated_files"],
)

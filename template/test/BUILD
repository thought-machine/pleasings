subinclude("//template:template")

template_files(
    name = "generated_files",
    srcs = ["templated.yaml"],
    substitutions = {
        "//template/test:single_line":"value",
        ":single_line_local":"value",
        "//template/test:concatenated":"value",
        "//template/test:special_chars":"value",
        # "//randomthing",
    },
    outs = ["generated.yaml"],
    visibility = ["//template/test/..."],
)

python_test(
    name = "template_test",
    data = ["expected.yaml",
            ":generated_files"],
    srcs = ["template_test.py"],
    deps = [":generated_files"],
)

template_value(
    name = "single_line",
    cmd = "echo 'testing a single line'",
    visibility = ["//template/test/..."],
)

template_value(
    name = "single_line_local",
    cmd = "echo 'testing a single line local'",
    visibility = ["//template/test/..."],
)

template_value(
    name = "concatenated",
    cmd = "echo 'concatenated'",
    visibility = ["//template/test/..."],
)

template_value(
    name = "special_chars",
    cmd = r"echo 'contains $.*[\]^|/&\\'",
    visibility = ["//template/test/..."],
)

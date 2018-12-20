subinclude("//template:template")

template_files(
    name = "generated_files_dict",
    srcs = ["template_dict.yaml"],
    subs = {
        "//template/test:single_line":"//template/test:single_line_value",
        ":single_line_local":":single_line_local_value",
        "//template/test:concatenated":"//template/test:concatenated_value",
        "//template/test:special_chars":"//template/test:special_chars_value",
        "random_string_in_quotes": "//template/test:single_line_value",
    },
    outs = ["generated_dict.yaml"],
    visibility = ["//template/test/..."],
)

template_files(
    name = "generated_files_list",
    srcs = ["template_list.yaml"],
    subs = [
        "//template/test:single_line_value",
        ":single_line_local_value",
        "//template/test:concatenated_value",
        "//template/test:special_chars_value",
    ],
    outs = ["generated_list.yaml"],
    visibility = ["//template/test/..."],
)

python_test(
    name = "template_test",
    data = ["expected.yaml",
            ":generated_files_dict",
            ":generated_files_list"],
    srcs = ["template_test.py"],
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

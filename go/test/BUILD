subinclude("//go:go_bindata")

go_bindata(
    name = "embedded_data",
    srcs = ["test.txt"],
)

go_test(
    name = "bindata_test",
    srcs = [
        "bindata_test.go",
        ":embedded_data",
    ],
    deps = ["//third_party/go:testify"],
)

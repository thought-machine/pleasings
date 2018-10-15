go_library(
    name = "signer",
    srcs = ["signer.go"],
    visibility = ["//signing/release_signer"],
    deps = [
        "//third_party/go:openpgp",
    ],
)

go_test(
    name = "signer_test",
    srcs = ["signer_test.go"],
    data = ["test_data"],
    deps = [
        ":signer",
        "//third_party/go:openpgp",
        "//third_party/go:testify",
    ],
)

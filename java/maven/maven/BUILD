package(GO_IMPORT_PATH = "github.com/thought-machine/pleasings")

go_library(
    name = "maven",
    srcs = [
        "fetch.go",
        "graph.go",
        "pom.go",
        "print.go",
        "resolver.go",
    ],
    visibility = ["//java/maven:all"],
    deps = [
        "//third_party/go:go-flags",
        "//third_party/go:logging",
        "//third_party/go:queue",
    ],
)

go_test(
    name = "maven_test",
    srcs = ["maven_test.go"],
    data = ["test_data"],
    deps = [
        ":maven",
        "//third_party/go:cli-init",
        "//third_party/go:testify",
    ],
)

go_test(
    name = "version_test",
    srcs = ["version_test.go"],
    deps = [
        ":maven",
        "//third_party/go:testify",
    ],
)

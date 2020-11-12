subinclude("//go:mock")

go_library(
    name = "foo",
    srcs = ["foo.go"],
)

go_mock(
    name = "mock",
    src_lib = ":foo",
    interfaces = ["Foo"],
    visibility = ["//go/test/gomock/..."],
)


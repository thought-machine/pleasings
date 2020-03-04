# This helps things work from a subinclude until https://github.com/thought-machine/please/issues/744 is fixed.
package(go_import_path = "github.com/thought-machine/pleasings")

go_binary(
    name = "please_maven",
    srcs = ["main.go"],
    visibility = ["PUBLIC"],
    deps = [
        "//third_party/go:cli-init",
        "//java/maven/maven",
    ],
)

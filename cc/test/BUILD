# A set of example rules that test ThinLTO.
# These are obviously too simple to illustrate any real performance benefits
# but do help to show that the rules work.
subinclude("//cc:thinlto")

# A recent version of Clang is required for ThinLTO.
# We're testing against the clang-6 packages from http://apt.llvm.org but
# you might reconfigure this to just 'clang' if you have that on your PATH.
package(
    cpp_tool = "clang++-6.0",
    ld_tool = "gold",
)

cc_library(
    name = "kitten",
    srcs = ["kitten.cc"],
    hdrs = ["kitten.h"],
)

cc_library(
    name = "cat",
    srcs = ["cat.cc"],
    hdrs = ["cat.h"],
    deps = [":kitten"],
)

cc_library(
    name = "litter",
    srcs = ["litter.cc"],
    hdrs = ["litter.h"],
    deps = [":kitten"],
)

cc_library(
    name = "family",
    srcs = [
        "families.cc",
        "family.cc",
    ],
    hdrs = [
        "families.h",
        "family.h",
    ],
    deps = [
        ":cat",
        ":litter",
    ],
)

cc_test(
    name = "test",
    srcs = ["test.cc"],
    deps = [":family"],
)

cc_binary(
    name = "bin",
    srcs = ["main.cc"],
    deps = [":family"],
)

sh_test(
    name = "bin_test",
    src = "test.sh",
    data = [":bin"],
)

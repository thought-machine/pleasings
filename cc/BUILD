cc_library(
    name = "unittest_main",
    srcs = ["unittest_main.cc"],
    linker_flags = ["-lUnitTest++"],
    visibility = ["PUBLIC"],
    deps = ["@unittest_cpp"],
)

filegroup(
    name = "thinlto",
    srcs = ["thinlto.build_defs"],
    visibility = ["PUBLIC"],
)

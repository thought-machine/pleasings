cc_library(
    name = "lib",
    hdrs = ["lib.h"],
    srcs = ["lib.cc"],
)

cc_test(
    name = "test",
    srcs = ["test.cc"],
    deps = [
        ":lib",
        "//cc:unittest_main",
    ],
    write_main = False,
)

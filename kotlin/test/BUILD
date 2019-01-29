subinclude("//kotlin")

kotlin_library(
    name = "lib",
    srcs = ["lib.kt"],
)

kotlin_binary(
    name = "bin",
    deps = [":lib"],
)

kotlin_test(
    name = "test",
    srcs = ["test.kt"],
    deps = [
        ":lib",
        "//third_party/java:junit",
        "//third_party/kotlin:kotlin_test",
    ],
)

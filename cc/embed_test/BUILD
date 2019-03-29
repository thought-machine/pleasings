subinclude("//cc:embed_binary")

cc_embed_binary(
    name = "embedded_file_1",
    src = "embedded_file_1.txt",
)

genrule(
    name = "embedded_file_3_gen",
    outs = ["embedded_file_3.txt"],
    cmd = "echo \"testing message 3\" > $OUT",
)

cc_embed_binary(
    name = "embedded_file_3",
    src = ":embedded_file_3_gen",
    deps = [":embedded_file_3_gen"],
)

cc_test(
    name = "embed_file_test",
    srcs = ["embed_file_test.cc"],
    labels = ["embed"],
    deps = [
        ":embedded_file_1",
        ":embedded_file_3",
    ],
)

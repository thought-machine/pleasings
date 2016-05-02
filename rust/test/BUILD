subinclude('//rust')

rust_library(
    name = 'lib',
    srcs = ['lib.rs'],
)

rust_binary(
    name = 'bin',
    main = 'main.rs',
    deps = [
        ':lib',
    ],
)

rust_test(
    name = 'test',
    srcs = ['lib.rs'],
)

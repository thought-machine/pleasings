subinclude("//scala")

scala_library(
    name = "hello",
    srcs = ["helloworld.scala"],
    scalac_flags = ["-verbose"],
)

scala_binary(
    name = "helloworld",
    srcs = ["helloworld.scala"],
    main_class = "HelloWorld",
)

scala_binary(
    name = "hello_with_dep",
    main_class = "net.thoughtmachine.please.scala.HelloWorld",
    deps = [":hello"],
)

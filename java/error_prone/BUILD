# Extended version of plz's javac_worker with support for Error Prone (http://errorprone.info)
java_binary(
    name = 'javac_worker',
    main_class = 'build.please.compile.ErrorProneCompiler',
    self_executable = True,
    deps = ['//java/error_prone/src/main/java/build/please/compile'],
    visibility = ['PUBLIC'],
)

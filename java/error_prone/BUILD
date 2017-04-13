# Extended version of plz's javac_worker with support for Error Prone (http://errorprone.info)
java_binary(
    name = 'javac_worker',
    main_class = 'net.thoughtmachine.build.Core3Compiler',
    self_executable = True,
    deps = ['//java/error_prone/src/java/net/thoughtmachine/build'],
    visibility = ['PUBLIC'],
)

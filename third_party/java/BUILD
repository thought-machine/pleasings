package(default_visibility = ['PUBLIC'])

maven_jar(
    name = 'protoc-gen-grpc-java',
    id = 'io.grpc:protoc-gen-grpc-java:1.1.2',
    binary = True,
)

maven_jar(
    name = 'protobuf',
    id = 'com.google.protobuf:protobuf-java:3.2.0',
)

maven_jar(
    name = 'guava',
    id = 'com.google.guava:guava:22.0',
)

maven_jars(
    name = 'grpc-all',
    id = 'io.grpc:grpc-all:1.1.2',
    exclude = ['guava'],
    deps = [
        ':guava',
        ':protobuf',
    ],
)

maven_jars(
    name = 'error_prone',
    id = 'com.google.errorprone:error_prone_core:2.0.14',
    exclude = ['guava'],
)

# For the Error Prone compiler we reuse most of the existing worker infrastructure.
# We've not put it on Maven or anything but we can get it from here.
# (The Java worker is architecture-independent of course, although the rest of the tarball isn't).
remote_file(
    name = 'plz',
    hashes = ['091a22d5e8fa5df08893e5abec2a8dd48db897c7'],
    url = 'https://get.please.build/linux_amd64/7.9.0/please_7.9.0.tar.gz',
)

genrule(
    name = 'plz_javac_worker',
    srcs = [':plz'],
    outs = ['javac_worker.jar'],
    cmd = 'tar -xzf $SRCS please/javac_worker && mv please/javac_worker $OUT',
)

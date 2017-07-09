package(default_visibility = ['PUBLIC'])

maven_jars(
    name = 'error_prone',
    id = 'com.google.errorprone:error_prone_core:2.0.14',
    exclude = [
        'guava',
        'error_prone_annotations',
    ],
)

# For the Error Prone compiler we reuse most of the existing worker infrastructure.
# We've not put it on Maven or anything but we can get it from here.
# (The Java worker is architecture-independent of course, although the rest of the tarball isn't).
remote_file(
    name = 'plz',
    hashes = ['3f20ec4ac8f4092dbe22fdeddf7f7b841a408333'],
    url = 'https://get.please.build/linux_amd64/8.1.1/please_8.1.1.tar.gz',
)

genrule(
    name = 'plz_javac_worker',
    srcs = [':plz'],
    outs = ['javac_worker.jar'],
    cmd = 'tar -xzf $SRCS please/javac_worker && mv please/javac_worker $OUT',
)

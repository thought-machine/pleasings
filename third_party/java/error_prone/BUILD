package(default_visibility = ["PUBLIC"])

maven_jars(
    name = "error_prone",
    id = "com.google.errorprone:error_prone_core:2.3.1",
)

# For the Error Prone compiler we reuse most of the existing worker infrastructure.
# We've not put it on Maven or anything but we can get it from here.
# (The Java worker is architecture-independent of course, although the rest of the tarball isn't).
remote_file(
    name = "plz",
    hashes = ["0e694b44ace150afa3e049b2107b0e25d2ac3665"],
    url = "https://get.please.build/linux_amd64/13.1.0/please_13.1.0.tar.gz",
)

genrule(
    name = "plz_javac_worker",
    srcs = [":plz"],
    outs = ["javac_worker.jar"],
    cmd = "tar -xzf $SRCS please/javac_worker && mv please/javac_worker $OUT",
)

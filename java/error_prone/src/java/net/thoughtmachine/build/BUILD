# This will become our default javac worker, so we obviously cannot build it with itself.
package(javac_tool = 'javac')

java_library(
    name = 'build',
    srcs = ['ErrorProneCompiler.java'],
    deps = [
        '//third_party/java:error_prone',
        '//third_party/java:plz_javac_worker',
    ],
    visibility = ['//java/error_prone/...'],
)

# Third-party dependencies for Android targets.
# A lot of these are generated via commands like:
#   plz tool maven -- -a com.android.support:appcompat-v7:25.3.1@aar
# with a few manual fixups.
#
# TODO(peterebden): Introduce support for android_maven_jars to do
#                   that dynamically.

subinclude('//android')
package(default_visibility = ['PUBLIC'])
package(javac_tool = 'javac')

android_jar(
    name = 'android',
    platform = 'android-26',
)

android_maven_jar(
    name = 'appcompat-v7',
    id = 'com.android.support:appcompat-v7:25.3.1@aar',
    resources = True,
    deps = [
        ':animated-vector-drawable',
        ':support-annotations',
        ':support-v4',
        ':support-vector-drawable',
    ],
)

android_maven_jar(
    name = 'annotations',
    id = 'com.android.tools:annotations:24.1.0',
)

android_maven_jar(
    name = 'support-v4',
    id = 'com.android.support:support-v4:25.3.1@aar',
    deps = [
        ':support-compat',
        ':support-core-ui',
        ':support-core-utils',
        ':support-fragment',
        ':support-media-compat',
    ],
)

android_maven_jar(
    name = 'support-compat',
    id = 'com.android.support:support-compat:25.3.1@aar',
    deps = [
        ':support-annotations',
    ],
)

android_maven_jar(
    name = 'support-annotations',
    id = 'com.android.support:support-annotations:25.3.1',
)

android_maven_jar(
    name = 'support-media-compat',
    id = 'com.android.support:support-media-compat:25.3.1@aar',
    deps = [
        ':support-annotations',
        ':support-compat',
    ],
)

android_maven_jar(
    name = 'support-core-utils',
    id = 'com.android.support:support-core-utils:25.3.1@aar',
    deps = [
        ':support-annotations',
        ':support-compat',
    ],
)

android_maven_jar(
    name = 'support-core-ui',
    id = 'com.android.support:support-core-ui:25.3.1@aar',
    deps = [
        ':support-annotations',
        ':support-compat',
    ],
)

android_maven_jar(
    name = 'support-fragment',
    id = 'com.android.support:support-fragment:25.3.1@aar',
    deps = [
        ':support-compat',
        ':support-core-ui',
        ':support-core-utils',
        ':support-media-compat',
    ],
)

android_maven_jar(
    name = 'support-vector-drawable',
    id = 'com.android.support:support-vector-drawable:25.3.1@aar',
    hash = '',
    deps = [
        ':support-annotations',
        ':support-compat',
    ],
)

android_maven_jar(
    name = 'animated-vector-drawable',
    id = 'com.android.support:animated-vector-drawable:25.3.1@aar',
    hash = '',
    deps = [
        ':support-vector-drawable',
    ],
)

android_maven_jar(
    name = 'constraint-layout',
    id = 'com.android.support.constraint:constraint-layout:1.0.2@aar',
    resources = True,
    deps = [':constraint-layout-solver'],
)

android_maven_jar(
    name = 'constraint-layout-solver',
    id = 'com.android.support.constraint:constraint-layout-solver:1.0.2',
)

android_maven_jar(
    name = 'javax.inject',
    id = 'javax.inject:javax.inject:1',
)

android_maven_jar(
    name = 'dagger',
    id = 'com.squareup.dagger:dagger:1.2.2',
    deps = [
        ':javax.inject',
    ],
)

maven_jar(
    name = 'dagger-compiler',
    id = 'com.squareup.dagger:dagger-compiler:1.2.2',
    deps = [
        ':guava',
        ':javawriter',
    ],
)

maven_jar(
    name = 'guava',
    id = 'com.google.guava:guava:23.0',
)

maven_jar(
    name = 'javawriter',
    id = 'com.squareup:javawriter:2.5.1',
)

subinclude('//android')
package(default_visibility = ['PUBLIC'])

android_jar(
    name = 'android',
    platform = 'android-23',
)

android_maven_jar(
    name = 'appcompat-v7',
    id = 'com.android.support:appcompat-v7:23.0.1@aar',
)

android_maven_jar(
    name = 'support-annotations',
    id = 'com.android.support:support-annotations:23.0.1',
)

android_maven_jar(
    name = 'annotations',
    id = 'com.android.tools:annotations:24.1.0',
)

android_maven_jar(
    name = 'support-v4',
    id = 'com.android.support:support-v4:23.0.1',
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

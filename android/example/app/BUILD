subinclude('//android')
package(javac_tool = 'javac')

android_project(
    name = 'example_app',
    out = 'AsymmetricFingerprintDialog.apk',
    resource_deps = [
        '//third_party/android:appcompat-v7',
    ],
    deps = [
        '//third_party/android:annotations',
        '//third_party/android:dagger',
        '//third_party/android:dagger-compiler',
        '//third_party/android:javax.inject',
    ],
    visibility = ['//android/...'],
)

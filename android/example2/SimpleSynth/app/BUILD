subinclude('//android')
subinclude('//android:native')
package(javac_tool = 'javac')

ndk_toolchain(
    version = '4.9',
    arch = 'arm64',
    cflags = ['-Wno-unused-variable'],
    platform = 'android-26',
)

ndk_shared_object(
    name = 'native',
    srcs = glob(['src/main/cpp/*.cc']),
    out = 'libSimpleSynth.so',
    hdrs = glob(['src/main/cpp/*.h']),
    linker_flags = ['-lOpenSLES'],
)

android_project(
    name = 'simple_synth',
    out = 'SimpleSynth.apk',
    native_libs = [':native'],
    resource_deps = [
        '//third_party/android:appcompat-v7',
    ],
    deps = [
        '//third_party/android:appcompat-v7',
        '//third_party/android:support-v4',
    ],
    visibility = ['//android/example2/...'],
)

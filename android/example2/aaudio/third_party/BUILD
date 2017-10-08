subinclude('//android:native')
package(default_visibility = ['//android/example2/aaudio/...'])

ndk_toolchain(
    version = '4.9',
    arch = 'arm64',
    cflags = ['-Wno-unused-variable'],
    platform = 'android-26',
)

ndk_library(
    name = 'aaudio_utils',
    srcs = glob(['aaudio/utils/*.cc']),
    hdrs = glob(['aaudio/utils/*.h']),
    includes = ['aaudio/utils'],
    deps = [':android'],
)

ndk_c_library(
    name = 'wrapper',
    srcs = ['aaudio/wrapper/src/aaudio_wrapper.c'],
    hdrs = ['aaudio/wrapper/include/AAudio_Wrapper.h'],
    includes = ['aaudio/wrapper'],
)

ndk_library(
    name = 'android',
    srcs = glob(['android/*.cc']),
    hdrs = glob(['android/*.h']),
    includes = ['android'],
)

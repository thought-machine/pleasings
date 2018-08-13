subinclude('//js')
package(default_visibility = ['PUBLIC'])

# This creates a semi-standalone bundle of Webpack which we can use to build everything else.
webpack_bundle(
    name = 'webpack',
    srcs = [
        'plz_loader.js',
        'require_dynamic.js',
    ],
    build_config = 'build_config.js',
    config = 'config.js',
    main = 'main.js',
    webpack = '//third_party/js/webpack',
    deps = [
        '//third_party/js/webpack:babel-loader',
        '//third_party/js/webpack:babel-plugin-module-resolver',
        '//third_party/js/webpack:babel-preset-es2015',
        '//third_party/js/webpack:babel-preset-react',
        '//third_party/js/webpack:json-loader',
        '//third_party/js/webpack:loader-utils',
        '//third_party/js/webpack:replace-in-file-webpack-plugin',
    ],
)

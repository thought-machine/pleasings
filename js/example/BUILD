subinclude('//js')

# These rules are broken up more than is necessary to illustrate how the different
# libraries work together.
js_library(
    name = 'winner',
    srcs = ['winner.js'],
)

js_library(
    name = 'game',
    srcs = ['game.js'],
    deps = [
        ':winner',
        '//third_party/js:react',
    ],
)

js_binary(
    name = 'js',
    srcs = ['main.js'],
    out = 'game_compiled.js',
    bundles = [':vendor'],
    deps = [
        ':game',
        '//third_party/js:react-dom',
    ],
)

js_bundle(
    name = 'vendor',
    srcs = [
        '//third_party/js:react',
        '//third_party/js:react-dom',
    ],
)

filegroup(
    name = 'static_files',
    srcs = [
        'game.css',
        'game.html',
        ':js',
        ':vendor',
    ],
)

# Handy command that can be invoked with 'plz run' to open a browser to the example.
sh_cmd(
    name = 'example',
    cmd = 'sensible-browser plz-out/gen/$PKG/game.html',
    deps = [':static_files'],
)

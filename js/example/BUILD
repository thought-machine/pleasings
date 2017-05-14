subinclude('//js')

# TODO(peterebden): break this into a library + binary to illustrate
#                   importing one from another.
js_binary(
    name = 'js',
    srcs = ['game.js'],
    out = 'game.js',
    bundles = [':vendor'],
)

js_bundle(
    name = 'vendor',
    srcs = [
        '//third_party/js:react',
        '//third_party/js:react-dom',
    ],
)

filegroup(
    name = 'game',
    srcs = [
        'game.css',
        'game.html',
        ':js',
        ':vendor',
    ],
)

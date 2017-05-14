subinclude('//js')

# TODO(peterebden): break this into a library + binary to illustrate
#                   importing one from another.
js_binary(
    name = 'js',
    srcs = ['game.js'],
    out = 'game.js',
    deps = [
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
    ],
)

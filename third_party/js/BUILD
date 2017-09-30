subinclude('//js')
subinclude('//js:yarn')
package(default_visibility = ['PUBLIC'])

yarn_library(
    name = 'asap',
    version = '2.0.6',
)

yarn_library(
    name = 'base64-js',
    version = '1.2.1',
)

yarn_library(
    name = 'buffer',
    version = '5.0.7',
    deps = [
        ':base64-js',
        ':ieee754',
    ],
)

yarn_library(
    name = 'core-js',
    version = '1.2.7',
)

yarn_library(
    name = 'create-react-class',
    version = '15.6.0',
    deps = [
        ':fbjs',
        ':loose-envify',
        ':object-assign',
    ],
)

yarn_library(
    name = 'encoding',
    version = '0.1.12',
    deps = [
        ':iconv-lite',
    ],
)

yarn_library(
    name = 'fbjs',
    version = '0.8.15',
    deps = [
        ':core-js',
        ':isomorphic-fetch',
        ':loose-envify',
        ':object-assign',
        ':promise',
        ':setimmediate',
        ':ua-parser-js',
    ],
)

yarn_library(
    name = 'iconv-lite',
    version = '0.4.19',
    deps = [
        ':buffer',
        ':string_decoder',
    ],
)

yarn_library(
    name = 'ieee754',
    version = '1.1.8',
)

yarn_library(
    name = 'is-stream',
    version = '1.1.0',
)

yarn_library(
    name = 'isomorphic-fetch',
    version = '2.2.1',
    deps = [
        ':whatwg-fetch',
    ],
)

yarn_library(
    name = 'js-tokens',
    version = '3.0.2',
)

yarn_library(
    name = 'loose-envify',
    version = '1.3.1',
    deps = [
        ':js-tokens',
    ],
)

yarn_library(
    name = 'object-assign',
    version = '4.1.1',
)

yarn_library(
    name = 'promise',
    version = '7.3.1',
    deps = [
        ':asap',
    ],
)

yarn_library(
    name = 'prop-types',
    version = '15.5.10',
    deps = [
        ':fbjs',
        ':loose-envify',
    ],
)

yarn_library(
    name = 'react',
    version = '15.6.1',
    deps = [
        ':create-react-class',
        ':fbjs',
        ':loose-envify',
        ':object-assign',
        ':prop-types',
    ],
)

yarn_library(
    name = 'react-dom',
    version = '15.6.1',
    deps = [
        ':fbjs',
        ':loose-envify',
        ':object-assign',
        ':prop-types',
    ],
)

yarn_library(
    name = 'safe-buffer',
    version = '5.1.1',
    deps = [
        ':buffer',
    ],
)

yarn_library(
    name = 'setimmediate',
    version = '1.0.5',
)

yarn_library(
    name = 'string_decoder',
    version = '1.0.3',
    deps = [
        ':safe-buffer',
    ],
)

yarn_library(
    name = 'ua-parser-js',
    version = '0.7.14',
)

yarn_library(
    name = 'whatwg-fetch',
    version = '2.0.3',
)

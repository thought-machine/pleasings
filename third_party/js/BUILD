subinclude('//js:yarn')

remote_file(
    name = 'yarn',
    binary = True,
    hashes = ['d4920d5c273ad6c3ad9f0c5faa90b4f56215f70e'],
    url = 'https://github.com/yarnpkg/yarn/releases/download/v0.23.4/yarn-0.23.4.js',
)

yarn_library(
    name = 'babel-cli',
    version = '6.24.1',
    flat = True,
    visibility = ['PUBLIC'],
)

yarn_library(
    name = 'jest',
    version = '20.0.0',
    flat = True,
    visibility = ['PUBLIC'],
)

package(default_visibility = ['PUBLIC'])

pip_library(
    name = 'protobuf',
    version = '3.2.0',
    outs = ['google'],
    deps = [':six'],
)

pip_library(
    name = 'six',
    version = '1.10.0',
    outs = ['six.py'],
)

pip_library(
    name = 'grpc',
    package_name = 'grpcio',
    version = '1.1.0',
    zip_safe = False,  # Contains Cython code in a .so
    deps = [
        ':enum',
        ':futures',
        ':six',
    ],
)

pip_library(
    name = 'futures',
    version = '3.0.5',
    outs = ['concurrent'],
)

pip_library(
    name = 'enum',
    package_name = 'enum34',
    version = '1.1.6',
)

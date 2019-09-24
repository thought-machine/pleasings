subinclude('//proto:grpc_gateway')
package(proto_languages = [
    'go',
    'py',
])

# This is the googleapis dependency for grpc-gateway.
grpc_gateway_api(
    name = 'grpc_gateway_api',
    visibility = ['PUBLIC'],
)

protoc_binary(
    name = "protoc",
    version = "3.6.1",
    visibility = ["PUBLIC"],
)

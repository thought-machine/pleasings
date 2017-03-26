# Example usage of grpc_gateway_library rules.
subinclude('//grpc:grpc_gateway')

grpc_gateway_library(
    name = 'kitten',
    srcs = ['kitten.proto'],
)

grpc_swagger_library(
    name = 'kitten_swagger',
    srcs = [':kitten'],
)

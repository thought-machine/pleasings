package(default_visibility = ['PUBLIC'])

go_get(
    name = 'protoc-gen-grpc-gateway',
    binary = True,
    get = 'github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway',
)

go_get(
    name = 'protoc-gen-grpc-swagger',
    binary = True,
    get = 'github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-swagger',
)

go_get(
    name = 'googleapis',
    get = 'github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis',
)

go_get(
    name = 'context',
    get = 'golang.org/x/net/context',
)

go_get(
    name = 'grpc',
    exported_deps = [':context'],
    get = 'google.golang.org/grpc',
    deps = [':protobuf'],
)

go_get(
    name = 'protobuf',
    get = 'github.com/golang/protobuf/proto',
)

go_get(
    name = 'protoc-gen-go',
    binary = True,
    get = 'github.com/golang/protobuf/protoc-gen-go',
    deps = [':protobuf'],
)

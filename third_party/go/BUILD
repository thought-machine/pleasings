package(default_visibility = ['PUBLIC'])

go_get(
    name = 'protoc-gen-grpc-gateway',
    binary = True,
    get = 'github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway',
)

go_get(
    name = 'protoc-gen-swagger',
    binary = True,
    get = 'github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger',
)

go_get(
    name = 'context',
    get = 'golang.org/x/net/context',
)

go_get(
    name = 'grpc',
    exported_deps = [':context'],
    get = 'google.golang.org/grpc',
    revision = 'v1.5.0',
    deps = [':protobuf'],
)

go_get(
    name = 'protobuf',
    get = 'github.com/golang/protobuf/proto',
    install = ['github.com/golang/protobuf/protoc-gen-go/descriptor'],
)

go_get(
    name = 'protoc-gen-go',
    binary = True,
    get = 'github.com/golang/protobuf/protoc-gen-go',
    deps = [':protobuf'],
)

go_get(
    name = 'annotations',
    get = 'google.golang.org/genproto/googleapis/api/annotations',
    deps = [':protobuf'],
)

go_get(
    name = 'grpc-gateway-runtime',
    exported_deps = [':annotations'],
    get = 'github.com/grpc-ecosystem/grpc-gateway/runtime',
    deps = [
        ':grpc',
        ':protobuf',
    ],
)

go_get(
    name = 'go-flags',
    get = 'github.com/jessevdk/go-flags',
)

package(default_visibility = ["PUBLIC"])

go_get(
    name = "protoc-gen-grpc-gateway",
    binary = True,
    get = "github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway",
)

go_get(
    name = "protoc-gen-swagger",
    binary = True,
    get = "github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger",
)

go_get(
    name = "context",
    get = "golang.org/x/net/context",
)

go_get(
    name = "grpc",
    exported_deps = [":context"],
    get = "google.golang.org/grpc",
    deps = [":protobuf"],
)

go_get(
    name = "protobuf",
    get = "github.com/golang/protobuf/ptypes",
    install = ["github.com/golang/protobuf/protoc-gen-go/descriptor"],
)

go_get(
    name = "protoc-gen-go",
    binary = True,
    get = "github.com/golang/protobuf/protoc-gen-go",
    deps = [":protobuf"],
)

go_get(
    name = "annotations",
    get = "google.golang.org/genproto/googleapis/api/annotations",
    deps = [":protobuf"],
)

go_get(
    name = "grpc-gateway-runtime",
    exported_deps = [":annotations"],
    get = "github.com/grpc-ecosystem/grpc-gateway/runtime",
    deps = [
        ":grpc",
        ":protobuf",
    ],
)

go_get(
    name = "go-flags",
    get = "github.com/jessevdk/go-flags",
    revision = "v1.4.0",
)

go_get(
    name = "openpgp",
    get = "golang.org/x/crypto/openpgp/...",
    deps = [":cast5"],
)

go_get(
    name = "cast5",
    get = "golang.org/x/crypto/cast5",
)

go_get(
    name = "testify",
    get = "github.com/stretchr/testify",
    install = [
        "assert",
        "require",
        "vendor/github.com/davecgh/go-spew/spew",
        "vendor/github.com/pmezard/go-difflib/difflib",
    ],
    revision = "v1.2.2",
)

go_get(
    name = "cli-init",
    get = "github.com/peterebden/go-cli-init",
    revision = "v1.0.0",
    deps = [
        ":logging",
        ":terminal",
        ":go-flags",
    ],
)

go_get(
    name = "logging",
    get = "gopkg.in/op/go-logging.v1",
    revision = "b2cb9fa56473e98db8caba80237377e83fe44db5",
)

go_get(
    name = "terminal",
    get = "golang.org/x/crypto/ssh/terminal",
    revision = "505ab145d0a99da450461ae2c1a9f6cd10d1f447",
    deps = [":unix"],
)

go_get(
    name = "unix",
    get = "golang.org/x/sys/unix",
    revision = "1b2967e3c290b7c545b3db0deeda16e9be4f98a2",
)

go_get(
    name = "queue",
    get = "github.com/Workiva/go-datastructures/queue",
    revision = "v1.0.50",
)

go_get(
    name = "go-bindata",
    binary = True,
    get = "github.com/kevinburke/go-bindata/...",
    revision = "46eb4c183bfc1ebb527d9d19bcded39476302eb8",
    strip = ["testdata"],
)

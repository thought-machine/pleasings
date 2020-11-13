package(default_visibility = ["PUBLIC"])

go_get(
    name = "protoc-gen-grpc-gateway",
    binary = True,
    get = [],
    install = ["github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway"],
    deps = [
        ":glog",
        ":grpc",
        ":grpc-gateway",
        ":protobuf",
        ":net",
    ],
)

go_get(
    name = "protoc-gen-swagger",
    binary = True,
    get = [],
    install = ["github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger"],
    deps = [
        ":glog",
        ":grpc",
        ":grpc-gateway",
        ":protobuf",
        ":net",
    ],
)

go_get(
    name = "net",
    get = "golang.org/x/net/...",
    revision = "136a25c244d3019482a795d728110278d6ba09a4",
    deps = [
        ":terminal",
        ":text",
    ],
)

go_get(
    name = "tools",
    get = "golang.org/x/tools",
    install = [
        "cover",
        "go/packages",
    ],
    revision = "5bcca83a78812bd91ce8cb29be4fc4521cdc8f6f",
)

go_get(
    name = "text",
    get = "golang.org/x/text/...",
    revision = "4e4a3210bb54bb31f6ab2cdca2edcc0b50c420c1",
    deps = [
        ":tools",
    ],
)

go_get(
    name = "grpc",
    exported_deps = [":net"],
    get = "google.golang.org/grpc",
    install = [
        "",
        "balancer",
        "balancer/base",
        "balancer/roundrobin",
        "binarylog/...",
        "codes",
        "connectivity",
        "credentials",
        "credentials/internal",
        "encoding",
        "encoding/gzip",
        "encoding/proto",
        "grpclog",
        "health",
        "health/grpc_health_v1",
        "internal/...",
        "keepalive",
        "metadata",
        "naming",
        "peer",
        "resolver",
        "resolver/dns",
        "resolver/passthrough",
        "serviceconfig",
        "stats",
        "status",
        "tap",
    ],
    repo = "github.com/grpc/grpc-go",
    revision = "v1.22.0",
    deps = [
        ":protobuf",
        ":rpcstatus",
        ":unix",
    ],
)

go_get(
    name = "rpcstatus",
    get = "google.golang.org/genproto/googleapis/rpc/status",
    revision = "2b5a72b8730b0b16380010cfe5286c42108d88e7",
    deps = [":protobuf"],
)

go_get(
    name = "protobuf",
    get = "github.com/golang/protobuf/...",
    revision = "v1.3.2",
    strip = [
        "proto/proto3_proto",
        "conformance",
    ],
)

go_get(
    name = "protoc-gen-go",
    binary = True,
    get = [],
    install = ["github.com/golang/protobuf/protoc-gen-go"],
    deps = [
        ":protobuf",
    ],
)

go_get(
    name = "grpc-gateway",
    get = "github.com/grpc-ecosystem/grpc-gateway/...",
    licences = ["bsd-3-clause"],
    revision = "v1.6.3",
    strip = ["examples"],
    deps = [
        ":genproto_api",
        ":genproto_protobuf",
        ":glog",
        ":grpc",
        ":protobuf",
        ":net",
        ":yaml",
    ],
)

go_get(
    name = "genproto_api",
    get = "google.golang.org/genproto/googleapis/api",
    install = [
        "annotations",
    ],
    revision = "bd9b4fb69e2ffd37621a6caa54dcbead29b546f2",
    deps = [":protobuf"],
)

go_get(
    name = "genproto_protobuf",
    get = "google.golang.org/genproto/protobuf/...",
    revision = "bd9b4fb69e2ffd37621a6caa54dcbead29b546f2",
    deps = [
        ":protobuf",
    ],
)

go_get(
    name = "glog",
    get = "github.com/golang/glog",
    licences = ["apache-2.0"],
    revision = "23def4e6c14b4da8ac2ed8007337bc5eb5007998",
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

go_get(
    name = "yaml",
    get = "github.com/ghodss/yaml",
    licences = ["mit"],
    revision = "v1.0.0",
    deps = [":yaml.v2"],
)

go_get(
    name = "yaml.v2",
    get = "gopkg.in/yaml.v2",
    revision = "f7716cbe52baa25d2e9b0d0da546fcf909fc16b4",
)


go_get(
    name = "mockgen",
    binary = True,
    get = [],
    install = ["github.com/golang/mock/mockgen"],
    licences = ["apache-2.0"],
    deps = [":mock"],
)

go_get(
    name = "mock",
    get = "github.com/golang/mock/...",
    licences = ["apache-2.0"],
    revision = "v1.4.4",
    deps = [
        ":tools",
    ],
)


package(default_visibility = ["PUBLIC"])

go_mod_download(
    name = "grpc-gateway-dl",
    module = "github.com/grpc-ecosystem/grpc-gateway",
    version = "v1.6.3",
    strip = ["examples"],
)

go_module(
    name = "protoc-gen-grpc-gateway",
    binary = True,
    module = "github.com/grpc-ecosystem/grpc-gateway",
    install = ["protoc-gen-grpc-gateway"],
    download = ":grpc-gateway-dl",
    deps = [
        ":glog",
        ":grpc",
        ":grpc-gateway",
        ":protobuf",
        ":net",
    ],
)

go_module(
    name = "protoc-gen-swagger",
    binary = True,
    module = "github.com/grpc-ecosystem/grpc-gateway",
    install = ["protoc-gen-swagger"],
    download = ":grpc-gateway-dl",
    deps = [
        ":glog",
        ":grpc",
        ":grpc-gateway",
        ":protobuf",
        ":net",
    ],
)

go_module(
    name = "grpc-gateway",
    module = "github.com/grpc-ecosystem/grpc-gateway",
    install = ["..."],
    licences = ["bsd-3-clause"],
    download = ":grpc-gateway-dl",
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

go_module(
    name = "net",
    module = "golang.org/x/net",
    version = "136a25c244d3019482a795d728110278d6ba09a4",
    install = ["..."],
    deps = [
        ":terminal",
        ":text",
    ],
)

go_module(
    name = "tools",
    module = "golang.org/x/tools",
    install = [
        "cover",
        "present",
        "go/packages",
        "go/loader",
        "go/buildutil",
        "go/gcexportdata",
        "go/ast/...",
        "go/internal/...",
        "internal/...",
    ],
    version = "5bcca83a78812bd91ce8cb29be4fc4521cdc8f6f",
    deps = [":mod", ":sync"],
)

go_module(
    name = "mod",
    module = "golang.org/x/mod",
    version = "v0.4.2",
    install = ["module", "semver", "modfile"],
    deps = [":errors"],
)

go_module(
    name = "errors",
    module = "golang.org/x/xerrors",
    version = "v0.0.0-20200806184451-1a77d5e9f316",
)

go_module(
    name = "sync",
    module = "golang.org/x/sync",
    version = "v0.0.0-20210220032951-036812b2e83c",
    install = ["..."],
)

go_module(
    name = "text",
    module = "golang.org/x/text",
    install = ["..."],
    version = "4e4a3210bb54bb31f6ab2cdca2edcc0b50c420c1",
    deps = [
        ":tools",
    ],
)

go_module(
    name = "grpc",
    exported_deps = [":net"],
    module = "google.golang.org/grpc",
    install = [
        ".",
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
    version = "v1.22.0",
    deps = [
        ":protobuf",
        ":rpcstatus",
        ":unix",
    ],
)

go_module(
    name = "rpcstatus",
    module = "google.golang.org/genproto",
    install = ["googleapis/rpc/status"],
    version = "2b5a72b8730b0b16380010cfe5286c42108d88e7",
    deps = [":protobuf"],
)

go_module(
    name = "protobuf",
    module = "github.com/golang/protobuf",
    install = ["..."],
    version = "v1.3.2",
    strip = [
        "proto/proto3_proto",
        "conformance",
    ],
)

go_module(
    name = "protoc-gen-go",
    binary = True,
    module = "github.com/golang/protobuf",
    install = ["protoc-gen-go"],
    version = "v1.3.2",
    deps = [
        ":protobuf",
    ],
)


go_module(
    name = "genproto_api",
    module = "google.golang.org/genproto",
    install = [
        "googleapis/api/annotations",
    ],
    version = "bd9b4fb69e2ffd37621a6caa54dcbead29b546f2",
    deps = [":protobuf"],
)

go_module(
    name = "genproto_protobuf",
    module = "google.golang.org/genproto",
    install = ["protobuf/..."],
    version = "bd9b4fb69e2ffd37621a6caa54dcbead29b546f2",
    deps = [
        ":protobuf",
    ],
)

go_module(
    name = "glog",
    module = "github.com/golang/glog",
    licences = ["apache-2.0"],
    version = "23def4e6c14b4da8ac2ed8007337bc5eb5007998",
)

go_module(
    name = "go-flags",
    module = "github.com/jessevdk/go-flags",
    version = "v1.4.0",
)

go_module(
    name = "openpgp",
    module = "golang.org/x/crypto",
    install = ["openpgp/..."],
    version = "505ab145d0a99da450461ae2c1a9f6cd10d1f447",
    deps = [":cast5"],
)

go_module(
    name = "cast5",
    module = "golang.org/x/crypto",
    install= ["cast5"],
    version = "505ab145d0a99da450461ae2c1a9f6cd10d1f447",
)

go_module(
    name = "testify",
    install = [
        "assert",
        "require",
    ],
    licences = ["MIT"],
    module = "github.com/stretchr/testify",
    version = "v1.6.1",
    deps = [
        ":difflib",
        ":objx",
        ":spew",
        ":yaml.v3",
    ],
)

go_module(
    name = "spew",
    install = ["spew"],
    licences = ["ISC"],
    module = "github.com/davecgh/go-spew",
    version = "ecdeabc65495df2dec95d7c4a4c3e021903035e5",
)


go_module(
    name = "difflib",
    install = ["difflib"],
    licences = ["BSD 3-Clause"],
    module = "github.com/pmezard/go-difflib",
    version = "792786c7400a136282c1664665ae0a8db921c6c2",
)

go_module(
    name = "objx",
    licences = ["MIT"],
    module = "github.com/stretchr/objx",
    version = "1a9d0bb9f541897e62256577b352fdbc1fb4fd94",
)

go_module(
    name = "yaml.v3",
    licences = ["Apache 2.0"],
    module = "gopkg.in/yaml.v3",
    version = "v3.0.0-20200313102051-9f266ea9e77c",
)

go_module(
    name = "cli-init",
    module = "github.com/peterebden/go-cli-init",
    version = "v1.0.0",
    deps = [
        ":logging",
        ":terminal",
        ":go-flags",
    ],
)

go_module(
    name = "logging",
    module = "gopkg.in/op/go-logging.v1",
    version = "b2cb9fa56473e98db8caba80237377e83fe44db5",
)

go_module(
    name = "terminal",
    module = "golang.org/x/crypto",
    install = ["ssh/terminal"],
    version = "505ab145d0a99da450461ae2c1a9f6cd10d1f447",
    deps = [":unix"],
)

go_module(
    name = "unix",
    module = "golang.org/x/sys",
    install = ["unix"],
    version = "1b2967e3c290b7c545b3db0deeda16e9be4f98a2",
)

go_module(
    name = "queue",
    module = "github.com/Workiva/go-datastructures",
    install = ["queue"],
    version = "v1.0.50",
)

go_module(
    name = "go-bindata",
    binary = True,
    module = "github.com/kevinburke/go-bindata",
    install = ["go-bindata"],
    version = "46eb4c183bfc1ebb527d9d19bcded39476302eb8",
)

go_module(
    name = "yaml",
    module = "github.com/ghodss/yaml",
    licences = ["mit"],
    version = "v1.0.0",
    deps = [":yaml.v2"],
)

go_module(
    name = "yaml.v2",
    module = "gopkg.in/yaml.v2",
    version = "f7716cbe52baa25d2e9b0d0da546fcf909fc16b4",
)


go_mod_download(
    name = "mockgen-dl",
    module = "github.com/golang/mock",
    version = "v1.4.4",
)

go_module(
    name = "mockgen",
    binary = True,
    module = "github.com/golang/mock",
    download = ":mockgen-dl",
    install = ["mockgen"],
    licences = ["apache-2.0"],
    deps = [":tools"],
)

go_module(
    name = "mock",
    module = "github.com/golang/mock",
    install = ["..."],
    licences = ["apache-2.0"],
    download = ":mockgen-dl",
    deps = [
        ":tools",
    ],
)


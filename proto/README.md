Protocol Buffers
================

Additional rules related to [Protocol Buffers](https://developers.google.com/protocol-buffers/)
and [gRPC](https://grpc.io/).

Support for compiling both for C++, Java, Python, Go and Javascript
is built into Please, these are additional rules to add extra functionality.


gRPC Gateway
============

Rules extending the `grpc_library` rule to generate a [grpc-gateway](https://github.com/grpc-ecosystem/grpc-gateway)
stub for a reverse proxy server.

The `grpc_gateway_library` rule replaces `grpc_library`; it works identically
for all languages other than Go, which it produces the additional gateway code for.
It also adds an additional language, `swagger`, which generates a Swagger description
of the API. The usual way of getting at that is to use a `grpc_swagger_library`
which depends on the `grpc_gateway_library` rule.

In addition to the usual proto dependencies, you will need to set the following variables
in the `[buildconfig]` section of `.plzconfig`:
  * grpc-gateway-plugin: protoc plugin rule that is used for codegen. You can set this up
                         with a go_get rule to get github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway.
  * grpc-gateway-dep: proto dependency for grpc-gateway protos. Typically is a grpc_gateway_api rule.
  * grpc-gateway-go-dep: runtime grpc-gateway library. Needed to compile the Go rules.
                         You can again use a go_get rule, this time to fetch github.com/grpc-ecosystem/grpc-gateway/runtime.

There's an example of this in the `test` subdirectory.

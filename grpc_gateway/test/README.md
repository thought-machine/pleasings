grpc-gateway examples
=====================

This package contains examples of how to use the grpc_gateway rules.
Specifically it has rules to generate a Python gRPC server and Go gateway
which serve to illustrate how this all fits together.

To test them, run the following commands (you'll need a couple of shells for
the servers to run concurrently):
```
plz run //grpc_gateway/test:kitten_server
plz run //grpc_gateway/test:kitten_gateway
curl http://localhost:8080/api/v1/kitten
curl http://localhost:8080/api/v1/kitten/RUSSIAN_BLUE (if you have specific breed requirements)
```

You can use the following to generate the Swagger JSON documentation:
```
plz build //grpc_gateway/test\:kitten_swagger
```

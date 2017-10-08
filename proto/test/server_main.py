"""Implements a sample gRPC server which can be accessed through the gateway."""

import argparse, sys, time
from concurrent import futures
from third_party.python import grpc

# Some jiggling needed with modules since there are two things that both want
# to be 'import google'. If this was more than a toy example we might try
# to solve this more elegantly
from third_party.proto.google import api
sys.modules['google.api'] = api
import google
google.api = api

from grpc_gateway.test import kitten_pb2


class PetShop(kitten_pb2.PetShopServicer):

  def GetKitten(self, request, context):
      return kitten_pb2.GetKittenResponse(kitten=kitten_pb2.Kitten(
          name='Mr Tibbles',
          breed=kitten_pb2.Breed.Value(request.breed or 'HALP'),
          weight=1.2,
          age=7,
      ))


def main(args):
    # 10 concurrent kittens is probably sufficient...
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    kitten_pb2.add_PetShopServicer_to_server(PetShop(), server)
    server.add_insecure_port('[::]:%d' % args.port)
    server.start()
    try:
        print('Serving on port %d...' % args.port)
        while True:
            time.sleep(86400)
    except KeyboardInterrupt:
        server.stop(0)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Example gRPC server')
    parser.add_argument('--port', default=9090)
    main(parser.parse_args())

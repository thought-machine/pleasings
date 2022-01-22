"""Example Python web server."""

from http.server import BaseHTTPRequestHandler, HTTPServer
import sys


class Handler(BaseHTTPRequestHandler):

    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/plain')
        self.wfile.write(b'Hello world!\n')


def main():
    port = sys.argv[1]
    address = ('', int(port))
    server = HTTPServer(address, Handler)
    print('Serving on localhost:'+port)
    server.serve_forever()


if __name__ == '__main__':
    main()

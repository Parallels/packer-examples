import sys
import os
import mimetypes
from http.server import HTTPServer, SimpleHTTPRequestHandler

class NoCacheHandler(SimpleHTTPRequestHandler):
  def guess_type(self, path):
    return 'text/plain'

  def end_headers(self):
    self.send_header('Cache-Control', 'no-cache, no-store, must-revalidate')
    self.send_header('Pragma', 'no-cache')
    self.send_header('Expires', '0')
    SimpleHTTPRequestHandler.end_headers(self)

if __name__ == '__main__':
  if len(sys.argv) < 2:
    print('Usage: python server.py <path>')
    sys.exit(1)

  path = sys.argv[1]
  os.chdir(path)

  server_address = ('', 8000)
  httpd = HTTPServer(server_address, NoCacheHandler)
  print(f'Serving files from {path} at http://localhost:8000')
  httpd.serve_forever()

import os
from http.server import SimpleHTTPRequestHandler, HTTPServer
from pathlib import Path

PORT = int(os.environ.get("PORT", 8080))
WEB_ROOT = Path(os.environ.get("WEB_ROOT", "/app"))

class RootHandler(SimpleHTTPRequestHandler):
    # Always serve files from WEB_ROOT
    def translate_path(self, path):
        self.directory = str(WEB_ROOT)
        return super().translate_path(path)

    # If / (or /index.html) is requested and there's no index.html,
    # serve main.html as the default landing page.
    def do_GET(self):
        if self.path in ("/", "/index.html"):
            index = WEB_ROOT / "index.html"
            main = WEB_ROOT / "main.html"
            if (not index.exists()) and main.exists():
                self.path = "/main.html"
        return super().do_GET()

if __name__ == "__main__":
    os.chdir(WEB_ROOT)
    httpd = HTTPServer(("", PORT), RootHandler)
    print(f"Serving at port {PORT}")
    httpd.serve_forever()

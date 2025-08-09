import os
from pathlib import Path
from flask import Flask, send_from_directory, Response

WEB_ROOT = Path(os.environ.get("WEB_ROOT", "/app"))

app = Flask(__name__, static_folder=None)

def send_index_like():
    """Serve index.html if present, else main.html."""
    idx = WEB_ROOT / "index.html"
    main = WEB_ROOT / "main.html"
    if idx.exists():
        return send_from_directory(WEB_ROOT, "index.html")
    if main.exists():
        return send_from_directory(WEB_ROOT, "main.html")
    return Response("No index.html or main.html found.", status=404)

@app.route("/healthz")
def health():
    return "ok"

@app.route("/")
def root():
    return send_index_like()

@app.route("/<path:path>")
def catch_all(path: str):
    # If the requested file exists, serve it (css/js/img, etc.)
    target = WEB_ROOT / path
    if target.exists() and target.is_file():
        return send_from_directory(WEB_ROOT, path)
    # Otherwise SPA fallback to index/main
    return send_index_like()

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    app.run(host="0.0.0.0", port=port)

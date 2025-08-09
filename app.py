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

@app.get("/healthz")
def healthz():
    return "ok"

@app.get("/")
def root():
    return send_index_like()

@app.get("/<path:path>")
def catch_all(path: str):
    target = WEB_ROOT / path
    if target.exists() and target.is_file():
        return send_from_directory(WEB_ROOT, path)
    # SPA-style fallback for any route
    return send_index_like()

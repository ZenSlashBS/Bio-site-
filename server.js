// Minimal HTTP server for Railway
const express = require("express");
const path = require("path");
const compression = require("compression");

const app = express();
const PORT = process.env.PORT || 8080;

// Gzip assets
app.use(compression());

// Serve everything from the repo root (so index.html, 1.jpg, x.ico work)
app.use(express.static(path.join(__dirname), {
  maxAge: "1h",
  setHeaders: (res, filePath) => {
    // Basic security-ish headers
    res.setHeader("X-Content-Type-Options", "nosniff");
    res.setHeader("Referrer-Policy", "no-referrer-when-downgrade");
    // Cache-bust HTML
    if (filePath.endsWith(".html")) res.setHeader("Cache-Control", "no-cache");
  }
}));

// Root -> index.html
app.get("/", (_req, res) => {
  res.sendFile(path.join(__dirname, "index.html"));
});

// 404 fallback to index.html (optional, keeps single-page feel)
app.use((_req, res) => {
  res.status(200).sendFile(path.join(__dirname, "index.html"));
});

app.listen(PORT, () => {
  console.log(`✅ HTTP server running on port ${PORT}`);
});

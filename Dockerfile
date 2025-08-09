# Dockerfile (Flask + Gunicorn)
FROM python:3.12-slim

# Railway injects $PORT at runtime; default to 8080 for local runs
ENV PORT=8080 WEB_ROOT=/app PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1

WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the repo (includes main.html, assets, etc.)
COPY . .

EXPOSE 8080

# Start gunicorn bound to Railway's $PORT
CMD ["bash", "-lc", "exec gunicorn -w 2 -k gthread --threads 8 -b 0.0.0.0:${PORT} app:app"]

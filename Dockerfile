# Minimal Python image
FROM python:3.12-slim

# Railway will inject $PORT; default to 8080 for local runs
ENV PORT=8080 WEB_ROOT=/app

WORKDIR /app
COPY . /app

# (No deps needed; stdlib http.server)
EXPOSE 8080

CMD ["python", "server.py"]

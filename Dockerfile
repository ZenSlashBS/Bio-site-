FROM python:3.12-slim

ENV PORT=8080 WEB_ROOT=/app PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy your site + server
COPY . .

EXPOSE 8080
CMD ["python", "main.py"]

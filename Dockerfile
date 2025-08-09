# Dockerfile
FROM nginx:1.27-alpine

# Railway usually injects $PORT; default to 8080 for local runs
ENV PORT=8080

# Put site in nginx web root
WORKDIR /usr/share/nginx/html
COPY . .

# If you ship main.html, serve it as the landing page too
RUN [ -f main.html ] && cp -f main.html index.html || true

# Use nginx's templates feature to render PORT at startup
COPY default.conf.template /etc/nginx/templates/default.conf.template

# For local docs; Railway ignores EXPOSE but it's nice to have
EXPOSE 8080

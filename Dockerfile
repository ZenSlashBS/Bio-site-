# Dockerfile
FROM nginx:1.27-alpine

# Railway usually injects $PORT; default to 8080 for local runs
ENV PORT=8080

# Put site in nginx web root
WORKDIR /usr/share/nginx/html
COPY . .

# If you have main.html, make it the landing page
RUN [ -f main.html ] && cp -f main.html index.html || true

# Expose for local runs (Railway ignores EXPOSE)
EXPOSE 8080

# At runtime, update nginx to listen on $PORT, then start
CMD sh -c "sed -ri 's/listen\\s+80;/listen ${PORT};/' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"

# Dockerfile
FROM nginx:1.27-alpine

# App dir
WORKDIR /usr/share/nginx/html

# Copy site files (main.html, assets, etc.)
COPY . .

# Make main.html the landing page
# (keeps index.html if you already have one)
RUN [ -f main.html ] && cp -f main.html index.html || true

# Replace the default Nginx vhost
COPY default.conf /etc/nginx/conf.d/default.conf

# Railway usually injects $PORT, but your panel is set to 8080.
# We’ll adapt to either (fallback = 8080).
ENV PORT=8080

# On start, swap 8080 in the config with $PORT (if Railway sets it),
# then run Nginx in the foreground.
CMD sh -c "sed -i \"s/listen 8080;/listen ${PORT};/\" /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"

EXPOSE 8080

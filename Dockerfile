# Use a tiny, fast Nginx image
FROM nginx:1.27-alpine

# Work in the default web root
WORKDIR /usr/share/nginx/html

# Copy everything (css/js/images etc.)
COPY . .

# Make main.html the default landing page
RUN cp -f main.html index.html

# Optional: basic healthcheck
HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://localhost/ >/dev/null || exit 1

EXPOSE 80

# Nginx default CMD is fine

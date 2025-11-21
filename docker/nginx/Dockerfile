ARG NGiNX

FROM nginx:${NGiNX}

LABEL org.opencontainers.image.description="NGiNX proxy for Satis in Kubernetes"

# Install the GNU Compiler Collection
RUN apt-get update && apt-get install -y \
        gcc mono-mcs \
    && rm -rf /var/lib/apt/lists/*

# Copy the NGiNX configuration files
COPY default.conf /etc/nginx/conf.d
COPY nginx.pid /var/log/nginx
COPY nginx.conf /etc/nginx

# Claim ownership for the NGiNX user
RUN chown -R nginx:nginx /usr/share/nginx /var/log/nginx /var/cache/nginx /etc/nginx
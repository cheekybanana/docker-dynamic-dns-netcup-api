# ========================================
# Base image
# ========================================
FROM php:8.2-cli-alpine

# Install required packages
RUN apk add --no-cache bash curl

# Set working directory
WORKDIR /app

# Copy PHP code into container
COPY *.php /app/

# Copy entrypoint script
COPY ./run.sh /usr/local/bin/run.sh

# Make run.sh executable
RUN chmod +x /usr/local/bin/run.sh

# Set default environment variables (can be overridden via .env)
ENV UPDATE_INTERVAL=300 \
    USE_IPV4=true \
    USE_IPV6=false \
    CHANGE_TTL=true

# Start script
CMD ["/usr/local/bin/run.sh"]

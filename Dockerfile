FROM alpine:latest

# Install dependencies
RUN apk add --no-cache \
    ca-certificates \
    unzip \
    wget

# Download PocketBase (check for latest version at https://github.com/pocketbase/pocketbase/releases)
ARG PB_VERSION=0.22.20
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip \
    && unzip pocketbase_${PB_VERSION}_linux_amd64.zip -d /usr/local/bin/ \
    && chmod +x /usr/local/bin/pocketbase \
    && rm pocketbase_${PB_VERSION}_linux_amd64.zip

# Create data directory
RUN mkdir -p /pb_data /pb_migrations

EXPOSE 8080

# Start PocketBase
CMD ["/usr/local/bin/pocketbase", "serve", "--http=0.0.0.0:8080"]
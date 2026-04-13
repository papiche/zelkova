# Dockerfile - Ẑelkova ẐEN MULTIPASS Wallet
# Multi-stage build: Flutter web build → nginx

# Stage 1: Build Flutter web app
FROM ghcr.io/cirruslabs/flutter:3.41.2 AS builder

WORKDIR /app

# Copy dependency files first for better Docker layer caching
COPY pubspec.yaml pubspec.lock ./
COPY packages/duniter_indexer/pubspec.yaml packages/duniter_indexer/
COPY packages/duniter_datapod/pubspec.yaml packages/duniter_datapod/

# Get dependencies
RUN flutter pub get

# Copy all source code
COPY . .

# Build web release
RUN flutter build web --release --no-wasm-dry-run

# Stage 2: Serve with nginx
FROM nginx:alpine

# Copy built web app from builder stage
COPY --from=builder /app/build/web /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf.template /etc/nginx/conf.d/default.conf

# Copy entrypoint for env variable injection
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Build stage
FROM node:22-alpine AS builder

WORKDIR /app

COPY foodieapp/package*.json ./
RUN npm install

COPY foodieapp/ .
RUN npm run build

# Runtime stage
FROM nginx:alpine

# Remove entrypoint scripts and default configs
RUN rm -rf /etc/nginx/conf.d/* /docker-entrypoint.d/*

# Copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Copy build
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
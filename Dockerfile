# -------- Build stage --------
FROM node:22-alpine AS builder

WORKDIR /app

COPY foodieapp/package*.json ./
RUN npm install

COPY foodieapp/ .
RUN npm run build


# -------- Runtime stage --------
FROM nginx:alpine

# Remove ONLY default site config (not everything)
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom server config instead of replacing full nginx.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy built app
COPY --from=builder /app/dist /usr/share/nginx/html

# Ensure proper permissions (important for ECS)
RUN chmod -R 755 /usr/share/nginx/html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
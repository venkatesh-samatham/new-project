# --- Stage 1: Build ---
FROM node:20-alpine AS builder
WORKDIR /app
#COPY app/package*.json ./
#RUN npm install
COPY ..
# (Add build command here if using TypeScript/React, e.g., RUN npm run build)

# --- Stage 2: Runtime ---
FROM node:20-alpine
WORKDIR /app
# Security: Run as non-root
RUN addgroup -S devopsgroup && adduser -S devopsuser -G devopsgroup
USER devopsuser

# Copy only the essentials from the builder
COPY --from=builder /app ./
EXPOSE 3000
CMD ["node", "server.js"]

# Etapa 1: build da aplicação
FROM node:20-alpine AS builder

WORKDIR /app

COPY app/package*.json ./
RUN npm install

COPY app .
RUN npm run build

# Etapa 2: produção
FROM node:20-alpine

WORKDIR /app

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./
RUN npm install --production

EXPOSE 3000
CMD ["node", "dist/main"]
# Etapa 1: build
FROM node:20-alpine AS builder

WORKDIR /app

# Copia apenas os arquivos necessários de dentro da pasta app/
COPY app/package*.json ./
COPY app/tsconfig*.json ./
COPY app/nest-cli.json ./
COPY app/src ./src
COPY app/migrations ./migrations
COPY app/typeOrm.config.ts ./

RUN npm install
RUN npm run build

# Etapa 2: produção
FROM node:20-alpine

WORKDIR /app

COPY --from=builder /app/dist ./dist
COPY app/package*.json ./
RUN npm install --production

EXPOSE 3000
CMD ["node", "dist/main"]
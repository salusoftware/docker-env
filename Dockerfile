# Etapa 1: build
FROM node:20-alpine AS builder

WORKDIR /app

# Copia os arquivos necessários de dentro da pasta app/
COPY app/package*.json ./
COPY app/tsconfig*.json ./
COPY app/nest-cli.json ./nest-cli.json
COPY app ./app

RUN npm install
RUN npm run build

# Etapa 2: produção
FROM node:20-alpine

WORKDIR /app

# Copia o dist gerado na etapa anterior
COPY --from=builder /app/dist ./dist
COPY app/package*.json ./
RUN npm install --production

EXPOSE 3000
CMD ["node", "dist/main"]
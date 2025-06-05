# Etapa 1: build
FROM node:20-alpine AS builder

WORKDIR /app

# Copia arquivos da raiz
COPY package*.json ./
COPY tsconfig*.json ./
COPY nest-cli.json ./

# Copia o código do app
COPY app ./app

RUN npm install
RUN npm run build

# Etapa 2: produção
FROM node:20-alpine

WORKDIR /app

COPY --from=builder /app/dist ./dist
COPY package*.json ./
RUN npm install --production

EXPOSE 3000
CMD ["node", "dist/main"]
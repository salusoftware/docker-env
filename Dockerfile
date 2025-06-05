# Etapa 1 - Build
FROM node:20-alpine AS builder

WORKDIR /usr/src/app

# Copia somente os arquivos essenciais para build
COPY app/package*.json ./
COPY app/nest-cli.json ./
COPY app/tsconfig*.json ./
COPY app/src ./src

# Instala dependências e compila
RUN npm install
RUN npm run build

# Etapa 2 - Produção
FROM node:20-alpine

WORKDIR /app

# Copia apenas o resultado da build
COPY --from=builder /usr/src/app/dist ./dist
COPY app/package*.json ./

RUN npm install --omit=dev

CMD ["node", "dist/main"]
# ================================
# Etapa 1: Build
# ================================
FROM node:20 AS builder

WORKDIR /app

# Copia apenas os arquivos de dependência
COPY ./backend/package*.json ./

# Instala todas as dependências (incluindo dev para build)
RUN npm install

# Copia o restante da aplicação
COPY ./backend .

# Compila a aplicação NestJS
RUN npm run build


# ================================
# Etapa 2: Produção
# ================================
FROM node:20-alpine AS production

WORKDIR /app

# Copia apenas as dependências de produção
COPY --from=builder /app/node_modules ./node_modules

# Copia apenas o build e arquivos essenciais
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./

# Expõe a porta usada pela aplicação
EXPOSE 4200

# Comando para iniciar a aplicação
CMD ["node", "dist/main"]
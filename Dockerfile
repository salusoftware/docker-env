FROM node:20-alpine

WORKDIR /app

# Copia e instala as dependências
COPY package*.json ./
RUN npm install --production

# Instala o CLI globalmente (necessário para usar "nest build")
RUN npm install -g @nestjs/cli

# Copia o restante e compila
COPY . .
RUN nest build

EXPOSE 3000

CMD ["node", "dist/main.js"]
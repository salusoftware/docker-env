FROM node:20-alpine

WORKDIR /app

COPY app/package*.json ./
RUN npm install --production

COPY app .

RUN npm run build

EXPOSE 3000
CMD ["node", "dist/main"]
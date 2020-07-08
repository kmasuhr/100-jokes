FROM node:alpine as builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

FROM node:alpine as production

WORKDIR /app

COPY --from=builder /app/package*.json ./
COPY --from=builder /app/dist ./

RUN npm ci

CMD ["node", "main"]

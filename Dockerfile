FROM node:21-alpine3.18 as build

WORKDIR /app

COPY . .

RUN pnpm i

RUN pnpm run build

FROM node:21-alpine3.18 

WORKDIR /app

COPY --from=build /app/package*.json ./
COPY --from=build /app/build ./

EXPOSE 3000

CMD ["node","./index.js"]
FROM node:21-alpine as build

WORKDIR /app

COPY . .

RUN npm i -g pnpm

RUN pnpm i

RUN pnpm run build

FROM node:21-alpine 

WORKDIR /app

COPY --from=build /app/package*.json ./
COPY --from=build /app/build ./

EXPOSE 3000

CMD ["node","./index.js"]
FROM alpine:latest as base

WORKDIR /app

RUN apk add --no-cache lighttpd


FROM node:22-alpine as build

WORKDIR /app

COPY package.json /app/package.json

RUN npm install

COPY . /app

RUN npm run build

FROM base as final

COPY --from=build /app/dist /app

EXPOSE 80

RUN sed -i 's|server.document-root *=.*|server.document-root = "/app"|' /etc/lighttpd/lighttpd.conf

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
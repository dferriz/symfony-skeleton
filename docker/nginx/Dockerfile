FROM nginx:1.15-alpine

WORKDIR /app

RUN apk --update upgrade

COPY ./docker/etc/nginx/ /etc/nginx/

CMD ["nginx", "-g", "daemon off;"]
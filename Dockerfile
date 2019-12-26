FROM node:lts-alpine
MAINTAINER Seji64 <seji@tihoda.de>

RUN apk update && apk upgrade

RUN apk add --no-cache git && \
    apk add --no-cache nginx && \
    rm -rf /var/cache/apk/*

RUN adduser -D -g 'www' www && \
    mkdir /www && \
    mkdir -p /usr/share/nginx/html && \
    mkdir /run/nginx/ && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /www && \
    chown -R www:www /usr/share/nginx && \
    echo "daemon off;" >> /etc/nginx/nginx.conf

RUN cd /tmp/ && \
    git clone https://github.com/ll911/snapdrop

RUN mkdir -p /home/node/app && \
    cp -rv /tmp/snapdrop/server/* /home/node/app/ && \
    cp -rv /tmp/snapdrop/client/* /usr/share/nginx/html/ && \
    cp -rv /tmp/snapdrop/nginx/default.conf /etc/nginx/conf.d/default.conf && \
    rm -rf /tmp/snapdrop/
    
RUN sed -i "s|http://node:3000|http://127.0.0.1:3000|g" /etc/nginx/conf.d/default.conf

RUN cd /home/node/app && npm install

WORKDIR /home/node/app

CMD echo "Starting Snapdrop..." & node index.js & echo "Starting nginx..." & nginx

EXPOSE 80
    
STOPSIGNAL SIGTERM

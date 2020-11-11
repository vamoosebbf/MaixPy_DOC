FROM node:6-slim

MAINTAINER neucrack czd666666@gmail.com

ARG VERSION=3.2.1

LABEL version=$VERSION

RUN npm install --global gitbook-cli &&\
	gitbook fetch ${VERSION} &&\
	npm cache clear &&\
	rm -rf /tmp/*

WORKDIR /gitbook

VOLUME /gitbook /srv/html

EXPOSE 4000 35729

CMD chmod +x ./serve.sh && ./serve.sh

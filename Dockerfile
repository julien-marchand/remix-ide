FROM node:9.1-alpine

RUN apk update \
    && apk add ca-certificates wget \
    && update-ca-certificates \
    && apk --no-cache add git openssh g++ gcc libgcc libstdc++ linux-headers make python

RUN mkdir -p /usr/src/
WORKDIR /usr/src/

RUN wget https://github.com/ethereum/remix/archive/remix-lib@0.2.9.zip
RUN wget https://github.com/ethereum/remix-ide/archive/v0.6.3.zip
RUN unzip remix-lib@0.2.9.zip && unzip v0.6.3.zip

RUN mv ./remix-ide-0.6.3 ./remix-ide && mv ./remix-remix-lib-0.2.9 ./remix-ide/remix
WORKDIR /usr/src/remix-ide
RUN npm install && npm run linkremixcore && npm run linkremixlib && npm run linkremixsolidity
RUN npm run build

EXPOSE 8080

# За основу контейнера использую maven 3.6.0
FROM maven:3.6.0-jdk-8-alpine

MAINTAINER Dmitry Balashov

ENV REFRESHED_AT 2018–12–28

LABEL Description="My homework dockerfile" \
        Vendor="Balashov Dmitry" \
        Version="0.1"
USER root

# Добавляю terraform 
RUN \
        apk add --update ca-certificates \
     && apk add terraform

# Добавляю azure-cli, databricks-cli, openssl, jq
RUN \
        apk add --update \
        bash py-pip \
     && pip install --upgrade pip \
     && apk add --virtual=build gcc libffi-dev musl-dev openssl-dev python-dev make \
     && pip install virtualenv \
     && apk add jq \
     && apk add openssl \
     && apk add npm \
     && npm init --yes \
     && npm install npm@latest -g \
     && npm cache verify \
     && pip install azure-cli \
     && pip install --upgrade databricks-cli

# Добавляю angular-cli, python3
RUN \
        npm install -g @angular/cli@latest \
     && apk add python3 \
     && rm -rf /var/cache/apk/* \
     && rm -rf ~/.cache/pip/


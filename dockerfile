# .dockerignore で不要なファイルを除外
# コピー用途ならば ADD ではなく COPY
# USER を頻繁に使用しない
# RUN で cd するのではなく WORKDIR を利用
# ENV はまとめて一行にできる
# バックスラッシュで複数行に分ける
# EXPOSE は -P のヒント
# CMD は Dockerfile 内に一つだけ指定可能
# VOLUME で作成したボリュームは rm -v で削除可能

FROM ubuntu:16.04

RUN apt-get update && apt-get install -y curl git python build-essential 

RUN mkdir /node-red

WORKDIR /node-red

RUN apt-get install -y nodejs npm
RUN npm cache clean
RUN npm install n -g
# RUN n stable
RUN n 6.12.3
RUN ln -sf /usr/local/bin/node /usr/bin/node
RUN node -v
RUN apt-get purge -y nodejs npm

# Install app dependencies
COPY package.json ./package.json
RUN npm install

# Bundle app source
COPY setup.sh ./setup.sh
# COPY settings.js /src/settings.js

# ENV NODE_RED_USERNAME=$NODE_RED_USERNAME \
#     NODE_RED_PASSWORD=$NODE_RED_PASSWORD

ARG TESTENV
ARG NODE_RED_USERNAME
ARG NODE_RED_PASSWORD
ARG GIT_REPO_URL
ARG GIT_REPO_NAME

EXPOSE  3000

# docker build ./ -t example-nodered
# docker run -it \
#   -p 3030:3000 \
#   -e TESTENV='' \
#   -e NODE_RED_USERNAME='' \
#   -e NODE_RED_PASSWORD='' \
#   -e GIT_REPO_URL='' \
#   -e GIT_REPO_NAME='' \
#   example-nodered
CMD npm start

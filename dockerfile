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

RUN apt-get update && apt-get install -y curl python build-essential 

RUN mkdir /node-red

WORKDIR /node-red



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
CMD npm start

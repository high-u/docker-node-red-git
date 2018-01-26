# .dockerignore で不要なファイルを除外
# コピー用途ならば ADD ではなく COPY
# USER を頻繁に使用しない
# RUN で cd するのではなく WORKDIR を利用
# ENV はまとめて一行にできる
# バックスラッシュで複数行に分ける
# EXPOSE は -P のヒント
# CMD は Dockerfile 内に一つだけ指定可能
# VOLUME で作成したボリュームは rm -v で削除可能

FROM node:9.4.0-slim

RUN apt-get update && apt-get -y upgrade && apt-get install -y curl git python build-essential libudev-dev

RUN mkdir /node-red

WORKDIR /node-red

# RUN apt-get install -y nodejs npm
# RUN npm cache clean
# RUN npm install n -g
# # RUN n stable
# RUN n 8.9.4
# RUN ln -sf /usr/local/bin/node /usr/bin/node
# RUN node -v
# RUN apt-get purge -y nodejs npm

# Install app dependencies
COPY package.json ./package.json
RUN npm install

# Bundle app source
# COPY setup.js ./setup.js
COPY setup.sh ./setup.sh
# RUN chmod +x ./setup.sh
# COPY settings.js /src/settings.js
# COPY flows_cred.json ./flows_cred.json

# ENV NODE_RED_USERNAME=$NODE_RED_USERNAME \
#     NODE_RED_PASSWORD=$NODE_RED_PASSWORD

ARG TESTENV
ARG NODE_RED_USERNAME
ARG NODE_RED_PASSWORD
ARG GIT_REPO_URL
ARG GIT_REPO_NAME
ARG GIT_DOMAIN
ARG GIT_USERNAME
ARG GIT_PASSWORD

EXPOSE  3000

# docker build ./ -t example-nodered
# docker run -it \
#   -p 3030:3000 \
#   -e TESTENV='hoge' \
#   -e NODE_RED_USERNAME='admin' \
#   -e NODE_RED_PASSWORD='$2a$08$zZWtXTja0fB1pzD4sHCMyOCMYz2Z6dNbM6tl8sJogENOMcxWV9DN.' \
#   -e GIT_REPO_URL='https://github.com/high-u/node-red-test-git.git' \
#   -e GIT_REPO_NAME='node-red-test-git' \
#   example-nodered
CMD ["npm","run","startx"]
# CMD ["./setup.sh"]

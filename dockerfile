FROM    node:8.9.4-slim

# .dockerignore で不要なファイルを除外
# コピー用途ならば ADD ではなく COPY
# USER を頻繁に使用しない
# RUN で cd するのではなく WORKDIR を利用
# ENV はまとめて一行にできる
# バックスラッシュで複数行に分ける
# EXPOSE は -P のヒント
# CMD は Dockerfile 内に一つだけ指定可能
# VOLUME で作成したボリュームは rm -v で削除可能




# Install app dependencies
COPY package.json /src/package.json
RUN cd /src; npm install

# Bundle app source
COPY setup.js /src/setup.js
COPY settings.js /src/settings.js

# docker run -e TESTENV="hoge" example
ARG TESTENV

# ENV NODE_RED_USERNAME=$NODE_RED_USERNAME \
#     NODE_RED_PASSWORD=$NODE_RED_PASSWORD

EXPOSE  3000
CMD cd /src; npm start

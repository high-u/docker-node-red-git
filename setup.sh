#!/bin/sh

cd /node-red
git clone $GIT_REPO_URL
cd $GIT_REPO_NAME
npm install

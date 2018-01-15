#!/bin/sh

cd /node-red
git clone $GIT_REPO_SSH
cd $GIT_REPO_NAME
npm install

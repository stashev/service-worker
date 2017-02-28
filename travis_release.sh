#!/bin/bash

set -ev

TARGET_BRANCH=release

chmod 600 release_key
eval `ssh-agent -s`
ssh-add release_key

mkdir temp-git
cd temp-git

git clone -b $TARGET_BRANCH --single-branch "git@github.com:AutoScout24/service-worker.git" .
git config user.name "Travis CI"
git config user.email "${GIT_EMAIL}"
git config push.default simple
git checkout $TARGET_BRANCH

mkdir dist
cp -r ../service-worker/* ./dist
cp ../package.json .

git add . -A
git commit -am "Release"
git push origin $TARGET_BRANCH

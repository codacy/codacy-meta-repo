#!/usr/bin/env bash

BASE_FOLDER=repos
ORG_NAME=$(basename `pwd` -meta-repo)

meta init --force
mkdir -p $BASE_FOLDER

node update_repo_list.js $ORG_NAME $BASE_FOLDER

cat .repos.txt | xargs -L1 meta project import

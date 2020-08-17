#!/usr/bin/env bash

BASE_FOLDER="repos"
ORG_NAME="codacy"

meta init --force
mkdir -p "$BASE_FOLDER"

# Outputs the repositories to .repos.txt in format: [repo] [url]
node update_repo_list.js "$ORG_NAME" "$BASE_FOLDER"

# Imports every repository fetched from update_repo_list.js
cat .repos.txt | xargs -L1 meta project import

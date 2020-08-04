#!/usr/bin/env bash

ORG_NAME=$(basename `pwd` -meta-repo)
BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"

BASE_FOLDER="repos"
PR_TITLE="${1:-meta: Update the common files from meta-repo}"
SOURCE_BRANCH_NAME="${2:-$(git rev-parse --abbrev-ref HEAD)}"
TARGET_BRANCH_NAME="${3:-master}"

echo "This step will create the PullRequests only, at this step, it is assumed that your branches are pushed."
echo ""
echo "You are creating PullRequests on the meta-repo and all tracked repositories from ${SOURCE_BRANCH_NAME} to ${TARGET_BRANCH_NAME} with:"
echo "> $PR_TITLE"
echo ""

echo "Do you want to continue? (y/n)"

read input
if [[ "$input" =~ ^(y|Y|yes|Yes)$ ]]; then
    node create_prs.js "${ORG_NAME}" "${BASE_FOLDER}" "${PR_TITLE}" "${SOURCE_BRANCH_NAME}" "${TARGET_BRANCH_NAME}"
    echo "Done!"
fi

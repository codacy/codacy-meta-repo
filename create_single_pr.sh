#!/usr/bin/env bash

ORG_NAME="codacy"
REPOSITORY_NAME="$(basename `pwd`)"

PR_TITLE="${1:-meta: Update the common files from meta-repo}"
SOURCE_BRANCH_NAME="${2:-$(git rev-parse --abbrev-ref HEAD)}"
TARGET_BRANCH_NAME="${3:-master}"

echo "Creating PullRequest on ${ORG_NAME}/${REPOSITORY_NAME} from ${SOURCE_BRANCH_NAME} to ${TARGET_BRANCH_NAME} with:"
echo "> $PR_TITLE"
echo ""

echo "Do you want to continue? (y/n)"


git diff "origin/${TARGET_BRANCH_NAME}".."origin/${SOURCE_BRANCH_NAME}" | cat | if grep -q ^; then
  node "$HOME/codacy-meta-repo/create_single_pr.js" "${ORG_NAME}" "${REPOSITORY_NAME}" "${PR_TITLE}" "${SOURCE_BRANCH_NAME}" "${TARGET_BRANCH_NAME}"
  echo "Done!"
else 
  echo "Empty diff, skipping"
fi

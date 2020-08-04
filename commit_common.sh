#!/usr/bin/env bash

COMMON_FOLDER="$(pwd)/common/"
BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"
COMMIT_MESSAGE="${1:-meta: Update the common files from meta-repo}"

echo "The meta repo is on branch -- $BRANCH_NAME -- make sure you run 'meta git status' to check the other repos."
echo "You can create a new branch on all the repositories with 'meta git checkout -b <branch-name>'"
echo ""
echo "You are commiting the contents of $COMMON_FOLDER on every tracked repo with message:"
echo "> $COMMIT_MESSAGE"
echo ""

echo "Do you want to continue? (y/n)"

read input
if [[ "$input" =~ ^(y|Y|yes|Yes)$ ]]; then
    echo "Copying files to every tracked repo"
    meta loop "cp -r $COMMON_FOLDER ."

    echo "Staging files to be commited"
    meta git add .

    echo "Commiting on every repo"
    meta git commit -m "$COMMIT_MESSAGE"

    echo "Done! You can check the status of your tracked repos with 'meta git status'"
fi

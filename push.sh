#!/usr/bin/env bash

BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"
PUSH_PR_LINKS_OUTPUT="$(pwd)/pr_links.out"

echo "The meta repo is on branch -- $BRANCH_NAME -- make sure you run 'meta git status' to check the other repos."
echo "You are pushing the current status of the meta-repo and every tracked repo."
echo "This process will clean your current $PUSH_PR_LINKS_OUTPUT"
echo ""

echo "Do you want to continue? (y/n)"

read input
if [[ "$input" =~ ^(y|Y|yes|Yes)$ ]]; then
    rm -f "$PUSH_PR_LINKS_OUTPUT"
    meta git push 2>&1 | grep -w "https://github.com" | awk '{print $2}' >> "$PUSH_PR_LINKS_OUTPUT"
    echo "Done! You can check the status of your tracked repos with 'meta git status'"
    echo "Links for PullRequest creation at $PUSH_PR_LINKS_OUTPUT"
fi

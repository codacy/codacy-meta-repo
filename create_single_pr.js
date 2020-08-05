const { Octokit } = require("@octokit/rest");
fs = require('fs');

const octokit = new Octokit({
  auth: process.env.PERSONAL_GITHUB_TOKEN
});

const orgName = process.argv[2]
const repositoryName = process.argv[3]
const title = process.argv[4]
const sourceBranch = process.argv[5]
const targetBranch = process.argv[6]

  octokit.pulls.create({
    owner: orgName,
    repo: repositoryName,
    title: title,
    head: sourceBranch,
    base: targetBranch,
  });

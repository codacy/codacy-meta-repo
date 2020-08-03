const { Octokit } = require("@octokit/rest");
fs = require('fs');

const octokit = new Octokit({
  auth: process.env.PERSONAL_GITHUB_TOKEN
});


const orgName = process.argv[2]
const baseFolder = process.argv[3]

octokit
  .paginate("GET /orgs/:org/repos?type=:visibility", {
    org: orgName,
    visibility: "public"
  })
  .then((repos) => {
    let fileContent = repos
      .filter(repo => repo.archived == false)
      .filter(repo => repo.name != `${orgName}-meta-repo`)
      .map(repo => `${baseFolder}/${repo.name} ${repo.ssh_url}`).join("\n")

    fs.writeFile(".repos.txt", fileContent, err => {if(err) console.log(err)})
    console.log("Repos written to .repos.txt in format: [repo] [url]")
  });

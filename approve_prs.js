const { Octokit } = require("@octokit/rest");

const octokit = new Octokit({
  auth: process.env.PERSONAL_GITHUB_TOKEN
});

const orgName = "codacy"


octokit
  .paginate("GET /orgs/:org/repos?type=:visibility", {
    org: orgName,
    visibility: "public"
  })
  .then((repos) => {
    let filteredRepos = repos
      .filter(repo => repo.archived == false)
    filteredRepos.forEach(repo => handleRepo(repo))
  });

//Each non-archived public repo
function handleRepo(repo) {

  console.log(repo.name)

  //The pulls.list is paginated, but we don't have that many PRs on any repo to matter
  octokit.pulls.list({
    owner: orgName,
    repo: repo.name,
  })
  .then((prs) => {
    prs.data.forEach(pr => handlePr(repo.name, pr))
  })
}

//Each PR
function handlePr(repoName, pr) {
  if(pr.title == "meta: No longer runs failing worflows for comments on pull requests") {
    approvePr(repoName, pr)
  }
}

//Approve each PR that is a meta PR
function approvePr(repoName, pr) {
  console.log( `Approving ${pr.title} on ${repoName}, number ${pr.number}`)
  octokit.pulls.createReview({
    owner: orgName,
    repo: repoName,
    pull_number: pr.number,
    event: "APPROVE"
  })

}
# axe-github meta-repo

It allows to do operations on multiple **public** repos of this organization.

### Requirements

* Node
* https://github.com/octokit/rest.js
* https://github.com/mateodelnorte/meta
* PERSONAL_GITHUB_TOKEN with read:org

### How to update/clone

Make sure that your folder maintains the naming convention \<orgName\>-meta-repo.
This will update your `.meta` and clone all your public repos to a `repos/` folder:

`./meta_update.sh`

# Codacy meta-repo

It allows to do operations on multiple **public** repos of this organization.
`common` is considered to be the source of truth for files that are copied
among different repositories.

## Requirements

* Node
* https://github.com/octokit/rest.js
* https://github.com/mateodelnorte/meta
  * https://github.com/mateodelnorte/meta-loop
    * `npm install meta-loop -g`
* PERSONAL_GITHUB_TOKEN with read:org

## Using codacy-meta-repo

Feel free to check [meta](https://github.com/mateodelnorte/meta) for better understanding
the underlying tool. This repository has some scripts to help you on opreations for
all tracked repositories.

### Updating and cloning the tracked repositories

Running `./meta_update.sh` will track and download all public repositories
on Codacy organization on GitHub.

### Commiting the contents of `common`

Running `./commit_common.sh` will copy and replace the contents in `common`
folder to every tracked repository.
Meaning that after changes on any file on the `common` folder, you can
rely on this script to commit those changes.

### Other operations on all tracked repositories

`meta` will perform operations on all tracked repositories,
for example, to push changes on all the repositories, you can:
> meta git push

You can also rely on `meta loop` for non-git operations,
for instance, to perform an `ls` on each tracked repo, you can:
> meta loop ls

## Underlying behaviour of the scripts

### `meta_update.sh`

Repositories are tracked based on the contents of `.meta`, repositories
are added and cloned with:
`meta project import [repo] [url]`

The `./meta_update.sh` script will fetch the names and urls of the public
repositories with the help of `update_repo_list.js`.

### `update_repo_list.js`

Uses [octokit](https://github.com/octokit/rest.js) to fetch the public
repositories information - name and url - and outputs them to `.repos.txt`
for consumpiton at the `meta project import` step.

### `commit_common.sh`

Relies on `meta loop` to copy and replace the contents in `common`
folder to every tracked repository.
After the files are added to every repository, it uses `meta git` to
stage and commit those files on each respective repository.

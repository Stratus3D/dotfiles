#!/bin/bash

############################
# clone_all_github_repos.sh
# This script clones down all public repositories a user has on GitHub.com.
############################

# Use `Stratus3D` as the default user, unless one is specified in an argument.
if [ $# -gt 0 ];
then
GITHUB_ORGANIZATION=$1
else
GITHUB_ORGANIZATION="Stratus3D"
fi

# the git clone cmd used for cloning each repository
# the parameter recursive is used to clone submodules, too.
GIT_CLONE_CMD="git clone --quiet --mirror --recursive "

# fetch repository list via github api
# grep fetches the json object key ssh_url, which contains the ssh url for the repository
REPOLIST=`curl --silent https://api.github.com/users/${GITHUB_ORGANIZATION}/repos -q | grep "\"ssh_url\"" | awk -F': "' '{print $2}' | sed -e 's/",//g'`

# loop over all repository urls and execute clone
for REPO in $REPOLIST; do
    ${GIT_CLONE_CMD}${REPO}
done

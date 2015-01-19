#!/bin/bash

############################
# clone_all_github_repos.sh
# This script clones down all public repositories a user has on GitHub.com.
############################

# This script is incomplete
# TODO:
# * Put everything in the development dir by default
# * Check for repository clashes

# Use `Stratus3D` as the default user, unless one is specified in an argument.
if [ $# -gt 0 ];
then
GITHUB_USER=$1
else
GITHUB_USER="Stratus3D"
fi

# the git clone cmd used for cloning each repository
# the parameter recursive is used to clone submodules, too.
GIT_CLONE_CMD="git clone --quiet --mirror --recursive "

echo "Fetching $GITHUB_USER's repositories from the GitHub API..."

# fetch repository list via github api
# grep fetches the json object key ssh_url, which contains the ssh url for the repository
REPOLIST=`curl --silent https://api.github.com/users/${GITHUB_USER}/repos -q | grep "\"ssh_url\"" | awk -F': "' '{print $2}' | sed -e 's/",//g'`

echo "Starting to clone down $GITHUB_USER's repositories..."

# loop over all repository urls and execute clone
for REPO in $REPOLIST; do
    
    ${GIT_CLONE_CMD}${REPO}
done

echo "Finished cloning the repositories"

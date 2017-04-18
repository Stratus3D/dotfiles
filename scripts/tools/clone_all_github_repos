#!/bin/bash -

############################
# clone_all_github_repos.sh
# This script clones down all public repositories a user has on GitHub.com.
############################

# This script is incomplete
# TODO:
# * Check for repository clashes

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

# Use `Stratus3D` as the default user, unless one is specified in an argument.
if [ $# -gt 0 ];
then
GITHUB_USER=$1
else
GITHUB_USER="Stratus3D"
fi

# Use $DEVELOPMENT_DIR as the default clone dir unless one is specificed in an
# argument, if $DEVELOPMENT_DIR is not set use $HOME.
CLONE_DIR=$DEVELOPMENT_DIR
if [ $# -gt 1 ];
then
    CLONE_DIR=$2
else
    CLONE_DIR=$HOME
fi

# the git clone cmd used for cloning each repository
# the parameter recursive is used to clone submodules, too.
GIT_CLONE_CMD="git clone --quiet --recursive "

echo "Fetching $GITHUB_USER's repositories from the GitHub API..."

# fetch repository list via github api
# grep fetches the json object key ssh_url, which contains the ssh url for the repository
REPOLIST=$(curl --silent https://api.github.com/users/${GITHUB_USER}/repos -q | grep "\"ssh_url\"" | awk -F': "' '{print $2}' | sed -e 's/",//g')

echo "Starting to clone down $GITHUB_USER's repositories into '$CLONE_DIR'..."

# loop over all repository urls and execute clone
cd $CLONE_DIR;

for REPO in $REPOLIST; do
    REPO_DIR=$(echo $REPO | sed 's%^.*/\([^/]*\)\.git$%\1%g')
    echo "Repo: $REPO_DIR"

    if [ -d $REPO_DIR ]; then
        # If repo exists cd into and fetch changes
        cd $REPO_DIR
        git fetch --tags
    else
        # Clone down repo and pull down all changes
        eval $GIT_CLONE_CMD$REPO
        cd $REPO_DIR
        git pull --all
    fi
    cd $CLONE_DIR
done

echo "Finished cloning the repositories"

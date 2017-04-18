#!/bin/bash -
# Bitbucket backup script
# backups all repos (including wiki and issues) of a user
#
# requires (in PATH):
# - hg (http://mercurial.selenic.com)
# - git (http://git-scm.com)
# - jq (http://stedolan.github.io/jq/)
# - curl (http://curl.haxx.se)
#
# variables that must be set
# - USER_NAME: the user name
# - API_KEY: api key of the user
# - BACKUP_LOCATION: the base path to store the backup

function backup_hg {
if [ -d "$1" ]; then
    cd $1
    hg pull
else
    hg clone -U ssh://hg@bitbucket.org/$2 $1
fi
                                        }

                                        function backup_git {
                                        if [ -d "$1" ]; then
                                            cd $1
                                            git pull
                                        else
                                            git clone -n git@bitbucket.org:$2 $1
                                        fi
                                    }

                                    function backup_scm {
                                    TYPE=$3
                                    REPO=$2
                                    REPO_BACKUP_LOCATION=$BACKUP_LOCATION/$REPO
                                    REPO_REMOTE_PATH=$REPO
                                    if [ "git" = "$1" ]; then
                                        REPO_REMOTE_PATH=$REPO_REMOTE_PATH.git
                                    fi
                                    if [ "repo" = "$TYPE" ]; then
                                        REPO_BACKUP_LOCATION=$REPO_BACKUP_LOCATION/repo
                                    elif [ "wiki" = "$TYPE" ]; then
                                        REPO_BACKUP_LOCATION=$REPO_BACKUP_LOCATION/wiki
                                        REPO_REMOTE_PATH=$REPO_REMOTE_PATH/wiki
                                    fi
                                    if [ "hg" = "$1" ]; then
                                        backup_hg $REPO_BACKUP_LOCATION $REPO_REMOTE_PATH
                                    elif [ "git" = "$1" ]; then
                                        backup_git $REPO_BACKUP_LOCATION $REPO_REMOTE_PATH
                                    fi
                                }

                                mkdir -p $BACKUP_LOCATION

                                repositories=$(curl -s -S --user $USER_NAME:$API_KEY https://api.bitbucket.org/2.0/repositories/$USER_NAME\?pagelen\=100 | jq -r '.values[] | "\(.full_name) \(.scm) \(.has_issues) \(.has_wiki)"')

                                OIFS="$IFS"
                                IFS=$'\n'
                                for repository in $repositories
                                do
                                    repository_name=$(echo $repository | cut -d ' ' -f1)
                                    has_issues=$(echo $repository | cut -d ' ' -f3)
                                    has_wiki=$(echo $repository | cut -d ' ' -f4)
                                    scm=$(echo $repository | cut -d ' ' -f2)

                                    echo "backing up $repository_name"
                                    echo "backing up $repository_name repo"
                                    backup_scm $scm $repository_name repo

                                    if [ "true" = "$has_wiki" ]; then
                                        echo "backing up $repository_name wiki"
                                        backup_scm $scm $repository_name wiki
                                    fi

                                    if [ "true" = "$has_issues" ]; then
                                        echo "backing up $repository_name issues"
                                        ISSUES_BACKUP_LOCATION=$BACKUP_LOCATION/$repository_name/issues
                                        mkdir -p $ISSUES_BACKUP_LOCATION
                                        curl -s -S --user $USER_NAME:$API_KEY https://api.bitbucket.org/1.0/repositories/$repository_name/issues > $ISSUES_BACKUP_LOCATION/issues.json
                                    fi
                                done
                                IFS="$OIFS"


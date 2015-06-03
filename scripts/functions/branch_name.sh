#! /bin/bash -

branch() {
    # Check if current directory is a git repository
    if $(git rev-parse > /dev/null 2>&1); then
        # Get the branch name
        BRANCH_NAME=$(git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3);

        # Echo branch name
        echo $BRANCH_NAME;
    fi
}

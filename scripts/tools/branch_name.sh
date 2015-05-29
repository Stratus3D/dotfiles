#! /bin/bash -

get_branch_name() {
    # Check if current directory is a git repository
    if $(git rev-parse > /dev/null 2>&1); then
        # Get the branch name
        BRANCH_NAME=$(git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3);

        # Make branch name uppercase (JIRA tickets are uppercase)
        UPPERCASE_BRANCH_NAME=$(echo "$BRANCH_NAME" | tr [a-z] [A-Z]);

        # Echo branch name
        echo $UPPERCASE_BRANCH_NAME;
    fi
}

get_branch_name;

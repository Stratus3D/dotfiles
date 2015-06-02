#! /bin/bash -

#source branch_name.sh

ticket_name() {
    # Get the branch name
    BRANCH_NAME="$(branch_name)";

    # Make branch name uppercase (JIRA tickets are uppercase)
    UPPERCASE_BRANCH_NAME=$(echo "$BRANCH_NAME" | tr [a-z] [A-Z]);

    # Echo branch name
    echo $UPPERCASE_BRANCH_NAME;
}

ticket_name;

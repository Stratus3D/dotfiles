#! /bin/bash -

ticket() {
    # Get the branch name
    BRANCH_NAME="$(branch)";

    # Make branch name uppercase (JIRA tickets are uppercase)
    UPPERCASE_BRANCH_NAME=$(echo "$BRANCH_NAME" | tr '[:lower:]' '[:upper:]');

    # Echo branch name
    echo $UPPERCASE_BRANCH_NAME;
}

jira_ticket() {
    # Get the uppercase branch name
    branch_name=$(ticket)

    # Remove everything after the numbers, only the start of the branch is the JIRA ticket name
    jira_ticket_name=$(echo $branch_name | sed 's/\(^[[:alpha:]]*-[0-9]*\)\(.*\)/\1/g')

    echo $jira_ticket_name
}

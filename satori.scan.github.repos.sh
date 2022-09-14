#!/bin/bash
# Scan Github repos with Satori CI

if [ "$2" == "" ]; then
    echo "Syntax: $0 GithubUserAccount SatoriPlaybook.yml"
else
    ORG=$1
    PLAYBOOK=$2
    OUTPUT=`curl -s "https://api.github.com/users/$ORG/repos?per_page=100" | jq '.[].full_name' | tr -d '"' 2>>/dev/null`
    if [ "$?" -eq "0" ]; then
        while read REPO; do
            echo "satori-cli scan $REPO -p $PLAYBOOK"
        done<<<"$OUTPUT"
    else
        echo "Error: does the user account exists?"
    fi
fi

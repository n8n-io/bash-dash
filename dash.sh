#!/usr/bin/env bash

declare -A COMMANDS

# Define the commands here
COMMANDS[test]="http://localhost:5678/webhook/test"

# ----------------------------------
# ------ NO CHANGES PAST HERE ------
# ----------------------------------

command=$1
if [ -z "$command" ]
then
    echo "The command is missing!"
    exit 0
fi

if [ -z "${COMMANDS[$command]}" ]
then
    echo "The command \"$command\" is not known!"
    exit 0
fi

url=${COMMANDS[$command]}

if [ "${@: -1}" == "--test" ]
then
    echo "*** TEST WEBHOOK ***"
    url="${url/\/webhook\//\/webhook-test\/}"
    parameter="${*:2:$#-2}" 
else
    parameter=${*:2}
fi

curl -d "command=$command&parameter=$parameter" -X POST ${url}
echo ""

#!/usr/bin/env bash

declare -A commands

# Define the commands here
commands[test]="http://localhost:5678/webhook/test"

# ----------------------------------
# ------ NO CHANGES PAST HERE ------
# ----------------------------------

command=$1
if [ -z "$command" ]
then
    echo "No command supplied!"
    echo
    echo "The following commands are supported:"
    for i in "${!commands[@]}"
    do
        echo -e " -  \e[1m$i \e[0m(${commands[$i]})"
    done
    exit 0
fi

if [ -z "${commands[$command]}" ]
then
    echo "The command \"$command\" is not known!"
    exit 0
fi

url=${commands[$command]}

if [ "${@: -1}" == "--test" ]
then
    echo "*** TEST WEBHOOK ***"
    url="${url/\/webhook\//\/webhook-test\/}"
    parameter="${*:2:$#-2}" 
else
    parameter=${*:2}
fi

echo -e "$(curl -s -d "command=$command&parameter=$parameter" -H "user-agent: bash-dash" -X POST $url)"
echo ""

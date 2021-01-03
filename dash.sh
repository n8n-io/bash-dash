#!/usr/bin/env bash

declare -A commands

# Define the commands here
commands[test]="http://localhost:5678/webhook/test"
commands[test2]="URL:http://localhost:5678/webhook/test|METHOD:POST|TEST-URL:http://localhost:5678/webhook-test/test"

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

method=GET
data=${commands[$command]}

if [[ $data = *"|"* ]]; then
    # 
    IFS='|' read -r -a array <<< "$data"

    for element in "${array[@]}"
    do
        if [[ $element = "URL:"* ]]; then
            url="${element:4}"
        elif [[ $element = "TEST-URL:"* ]]; then
            testurl="${element:8}"
        elif [[ $element = "METHOD:"* ]]; then
            method="${element:7}"
        fi
    done

    if [ -z "$url" ]; then
        echo "There is no URL defined for command \"$command\"!"
        exit 0
    fi
else
    url=$data
fi

if [ "${@: -1}" == "--test" ]
then
    echo "*** TEST WEBHOOK ***"
    parameter=${*:2:$#-2}
    if [ -z "$testurl" ]; then
        url="${url/\/webhook\//\/webhook-test\/}"
    else
        url=$testurl
    fi
else
    parameter=${*:2}
fi

if [[ $method = "POST" ]]; then
    echo -e "$(curl -s --data-urlencode "command=$command" --data-urlencode "parameter=$parameter" -H "user-agent: bash-dash" -X POST -G $url)"
else
    echo -e "$(curl -s --data-urlencode "command=$command" --data-urlencode "parameter=$parameter" -H "user-agent: bash-dash" -G $url)"
fi
echo ""
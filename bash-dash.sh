#!/usr/bin/env bash

# Load the available commands from external file
source ~/.bash-dash/commands.sh

# If no command got supplied list the available ones
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

# Update bash-dash
if [ "$command" = "--update" ]
then
	echo "Updating bash-dash!"
	{
		curl --fail --silent --show-error --output ~/.bash-dash/bash-dash.sh https://raw.githubusercontent.com/n8n-io/bash-dash/main/bash-dash.sh
	} || {
		echo "Update did fail!"
		exit 1
	}
	echo "Success!"
	exit 0
fi

if [ -z "${commands[$command]}" ]
then
	echo "The command \"$command\" is not known!"
	exit 1
fi

method=GET
data=${commands[$command]}

if [[ $data = *"|"* ]]; then
	# Command got defined via advanced format
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
		exit 1
	fi
else
	# Command got defined via simple format
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

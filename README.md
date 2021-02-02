# Bash-Dash

(Slash) Dash commands for the terminal. This was created for [n8n.io](https://n8n.io) but can be used with anything that can receive HTTP requests.

## Install

For Bash-Dash to work, [curl](https://curl.se/) has to be installed.

To install, run:

```bash
mkdir ~/.bash-dash && curl https://raw.githubusercontent.com/n8n-io/bash-dash/main/bash-dash.sh -o ~/.bash-dash/bash-dash.sh && chmod 711 ~/.bash-dash/bash-dash.sh && curl https://raw.githubusercontent.com/n8n-io/bash-dash/main/commands.sh -o ~/.bash-dash/commands.sh && echo "alias -- -=~/.bash-dash/bash-dash.sh" >> ~/.bashrc
```

## Usage

### Call command

A command can be called by a dash `-` followed by the command. For example, the `weather` command:

```bash
- weather
```

Moreover, parameters can be supplied by adding them after the command. For example:

```bash
- weather berlin
```

![Bash-Dash getting weather information from the terminal](https://i.imgur.com/1kzrNFl.png)
### Add commands

You can add new commands by editing the file `~/.bash-dash/commands.sh` and adding a new line to the `commands` array.

#### Simple Format

You can add a new command by adding the URL that should 
be called when the command is issued. It will then make a GET request (by default) to that URL.

For example, the following line would add the command `test` which calls the URL `http://localhost:5678/webhook/test`.
```bash
commands[test]="http://localhost:5678/webhook/test"
```

#### Advanced Format

For more control, the advanced format can be used. It is possible to define the following:

 - METHOD[optional]: The HTTP Request-Method (default: GET)
 - TEST-URL[optional]: The Test-URL to use (default: as described under "Call a test Webhook")
 - URL[required]: The URL that the bash-command should call

For example:
```bash
commands[test]="URL:http://localhost:5678/webhook/test|METHOD:GET|TEST-URL:http://localhost:5678/webhook-test/test"
```

### Call a test Webhook

Calling a test webhook is possible by adding `--test` as the last parameter. It will then call the URL that was defined as `TEST-URL`. If a test webhook wasn't defined, it replaces `/webhook/` with `/webhook-test/` in the URL.

## Examples

```bash
- sms wife Will be home late
- weather berlin
- serverStats production1 
```


### Requests

The requests that bash-dash makes are by default GET-requests. Optional call-commands
that are supplied will be sent as query parameters.
The server has min. 2 minutes to send a response which then gets printed in the terminal.

### Response formatting

It is possible to use backslash escapes.

The following example will display the word "green" in green color.

```bash
The following text is \033[32mgreen\033[0m
```

The different codes for colors, bold, underline, and so on can be found here:
https://misc.flogisoft.com/bash/tip_colors_and_formatting


## Backend

Anything that can receive HTTP request calls can be used with bash-dash. 

loading icon???


## License

Bash-Dash is [**Apache 2.0**](https://github.com/n8n-io/bash-dash/blob/main/LICENSE) licensed.

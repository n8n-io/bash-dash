# Bash-Dash

(Slash)Dash-Commands for the terminal. It got created for [n8n.io](https://n8n.io)
but can be used with anything that can receive HTTP requests.

## Install

For Bash-Dash to work curl has to be installed.

To install run:

```bash
mkdir ~/.dash-command && curl https://raw.githubusercontent.com/n8n-io/bash-dash-command/main/dash.sh -o ~/.dash-command/dash.sh && echo "alias -- -=~/.dash-command/dash.sh" >> ~/.bashrc
```

## Usage

### Call command

A command can be called by a dash `-` followed by the command. For example the `weather` command:
```bash
- weather
```

Also parameters can be supplied by simply adding them after the command. For example:
```bash
- weather berlin
```

### Add commands

Adding new commands is possible by editing the file `~/.dash-command/dash.sh` and adding a new line to the `commands` array.

#### Simple Format

The simplest way to add a new command is by just adding the URL that should 
be called. It will then by default make a GET request to that URL.

For example:
```bash
commands[test]="http://localhost:5678/webhook/test"
```

Would add the command `test` which calls the URL `http://localhost:5678/webhook/test`.

#### Advanced Format

For more control the advanced format can be used. There it is possible to to defined the following:

 - METHOD[optional]: The HTTP Request-Method (default: GET)
 - TEST-URL[optional]: The Test-URL to use (default: as described under "Call a test Webhook")
 - URL[required]: The URL the bash-command should call

For example:
```bash
commands[test]="URL:http://localhost:5678/webhook/test|METHOD:GET|TEST-URL:http://localhost:5678/webhook-test/test"
```

### Call a test Webhook

Calling a test webhook is possible by adding as last parameter `--test`. It will then
call the URL that got defined as `TEST-URL` or if none got defined it replaces 
`/webhook/` with `/webhook-test/` on the URL.

## Examples

```bash
- sms wife Will be home late
- weather berlin
- serverStats production1 
```


### Requests made

The request bash-dash makes are by default GET-requests. Optional call-commands
that got supplied will be send as query parameter.
The server has min. 2 minutes to send a response which then gets printed to the terminal.

### Response formatting

It is possible to use backslash escapes.

The following will for example display the word "green" in the color green.

```bash
The following text is \033[32mgreen\033[0m
```

The different codes for colors, bold, underline, ... can be found here:
https://misc.flogisoft.com/bash/tip_colors_and_formatting


## License

Bash-Dash is [**Apache 2.0**](https://github.com/n8n-io/bash-dash-command/blob/main/LICENSE) licensed.
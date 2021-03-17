# Bash-Dash (Beta)

(Slash) Dash commands for the terminal are commands that run a workflow . Bash-Dash is a project created for [n8n.io](https://n8n.io), . Though this Bash-Dash is created to be integrated with n8n workflows, you can use it with anything that can receive HTTP requests.

[[toc]]

## Installation

To use Bash-Dash, you need to have [curl](https://curl.se/) installed. Then, install Bash-Dash by running:

```bash
mkdir ~/.bash-dash && curl https://raw.githubusercontent.com/n8n-io/bash-dash/main/bash-dash.sh -o ~/.bash-dash/bash-dash.sh && chmod 711 ~/.bash-dash/bash-dash.sh && curl https://raw.githubusercontent.com/n8n-io/bash-dash/main/commands.sh -o ~/.bash-dash/commands.sh && echo "alias -- -=~/.bash-dash/bash-dash.sh" >> ~/.bashrc
```

## Usage

After installing Bash-Dash, you can test it and add your own custom commands.

### Call commands

To call a Bash-Dash command, type a dash `-` followed by the command you want. 

For example, a `weather` command is invoked like this:

```bash
- weather
```

You can supply additional parameters by typing them after the command. For example, to get the weather in Berlin, run:

```bash
- weather berlin
```
The output looks like this:

![Bash-Dash getting weather information from the terminal](https://i.imgur.com/1kzrNFl.png)


Bash-Dash comes only with a pre-specified test command. You can try it out by running:

```bash
- test
```


### Custom commands

You can create custom Bash-Dash commands for your personal use-cases. 
To do this, open the file `~/.bash-dash/commands.sh` and add a new line to the `commands` array. 
There are two possible formats in which you can add new commands, depending on how specific you need them to be: simple format and advanced format.

#### Simple Format

Add a new command by specifying the name of your custom command and the URL that should be called when the command is issued. The command will then make a GET request (by default) to that URL. Custom commands in simple format look like this:

```bash
commands[command_name]="YOUR_URL"
```

For example, to add the `weather` command, type:

```bash
commands[weather]="URL?"
```

#### Advanced Format

If you want more control over your custom commands, use the advanced format, which allows you to specify three parameters:

 - URL[required]: The URL that the bash-command should call
 - METHOD[optional]: The HTTP Request-Method (default: GET)
 - TEST-URL[optional]: The Test-URL to use (default: as described under "Call a test Webhook")

For example, to add the `test` command, type:
```bash
commands[test]="URL:http://localhost:5678/webhook/test|METHOD:GET|TEST-URL:http://localhost:5678/webhook-test/test"
```


### Update command
We are continuously improving the Bash-Dash. To update to the latest version, run:

```
- --update
```


### Call a test Webhook

You can call a test webhook by adding `--test` as the last parameter of a command. The command will then call the URL that was defined as `TEST-URL`. If a test webhook has not been defined, the command will replace `/webhook/` with `/webhook-test/` in the URL.


## Examples
There are many possible use-cases of Bash-Dash. To give you some ideas, here are some examples:

- `sms wife Will be home late` to send a messge to your partner
- `weather berlin` to return the current weather in Berlin
- `serverStats production1` to return server statistics

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

## License

Bash-Dash is [**Apache 2.0**](https://github.com/n8n-io/bash-dash/blob/main/LICENSE) licensed.

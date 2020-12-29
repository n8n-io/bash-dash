# Bash-Dash

(Slash)Dash-Commands for the terminal.

## Install

For Bash-Dash to work curl has to be installed.

To install run:

```bash
mkdir ~/.dash-command && curl https://raw.githubusercontent.com/n8n-io/bash-dash-command/main/dash.sh -o ~/.dash-command/dash.sh && echo "alias -- -=~/.dash-command/dash.sh" >> ~/.bashrc
```

## Usage
### Add commands

Adding new commands is possible by editing the file `~/.dash-command/dash.sh` and adding a new line to the `COMMANDS` array.

For example:
```bash
COMMANDS[test]="http://localhost:5678/webhook/test"
```

Would add the command `test` which calls the URL `http://localhost:5678/webhook/test`.


### Call command

A command can be called by a dash `-` followed by the command. For example the `weather` command:
```bash
- weather
```

Also parameters can be supplied by simply adding them after the command. For example:
```bash
- weather berlin
```

### Call a test Webhook

Calling a test webhook is possible by adding as last parameter `--test`. It will then replace `/webhook/` with `/webhook-test/`.


## License

Bash-Dash is [**Apache 2.0**](https://github.com/n8n-io/bash-dash-command/blob/main/LICENSE) licensed.
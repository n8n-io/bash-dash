# Bash-Dash (Beta)

(Slash) Dash commands are commands typed in the command line to run an action. Bash-Dash is a project created for [n8n.io](https://n8n.io) workflows, but you can use it with anything that can receive HTTP requests.

## Installation

To use Bash-Dash, you need to have [curl](https://curl.se/) installed. Then, install Bash-Dash by running:

```bash
mkdir ~/.bash-dash && curl https://raw.githubusercontent.com/n8n-io/bash-dash/main/bash-dash.sh -o ~/.bash-dash/bash-dash.sh && chmod 711 ~/.bash-dash/bash-dash.sh && curl https://raw.githubusercontent.com/n8n-io/bash-dash/main/commands.sh -o ~/.bash-dash/commands.sh && echo "alias -- -=~/.bash-dash/bash-dash.sh" >> ~/.bashrc
```

Bash-Dash requires bash version 4+. Unfortunately does Mac OS ship with the outdated bash version 3 (last patch is from 2006). We **highly** recommend upgrading it anyway.
[How to upgrade Bash on Mac OS](#Upgrade-Bash-on-Mac-OS)

## Usage

After installing Bash-Dash, you can test it and add your own custom commands.

### Update command

We are continuously improving the Bash-Dash. To update to the latest version, run:

```
- --update
```

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

Bash-Dash comes with a pre-specified test command. You can try it out by running:

```bash
- test
```

### Custom commands

You can create custom Bash-Dash commands for your personal use-cases. To do this, open the file `~/.bash-dash/commands.sh` and add a new line to the `commands` array. There are two possible formats in which you can add new commands, depending on how specific you need them to be: simple format and advanced format.

#### Simple Format

Add a new command by specifying the name of your custom command and the URL that should be called when the command is issued. The command will then make a GET request (by default) to that URL. Custom commands in simple format look like this:

```bash
commands[command_name]="YOUR_URL"
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

### Response formatting

You can format how the response gets displayed in the terminal by using backslash escapes `\`.

For example, to display the word "green" in green color, type:

```bash
The following text is \033[32mgreen\033[0m
```

If you use Bash-Dash with n8n workflows, you can edit the displayed text in the Response node. For example, the bash-dah-weather workflow displays the output like this:

![Bash-Dash getting weather information from the terminal](https://i.imgur.com/1kzrNFl.png)

You can find the different codes for colors and formatting options (e.g., bold, underline) [here](https://misc.flogisoft.com/bash/tip_colors_and_formatting).

### Call a test Webhook

You can call a test webhook by adding `--test` as the last parameter of a command. The command will then call the URL that was defined as `TEST-URL`. If a test webhook has not been defined, the command will replace `/webhook/` with `/webhook-test/` in the URL.

## Examples

There are many possible use-cases of Bash-Dash. To give you some ideas, here are some examples of n8n workflows:

- `- weather berlin` to return the current weather in Berlin. You can find the workflow [here](https://n8n.io/workflows/986).
- `- asana My new task` to create a new task in Asana. You can find the workflow [here](https://n8n.io/workflows/987).
- `- sms wife Will be home late` to send a messge to your partner
- `- serverStats production1` to return server statistics

## Backend

You can use Bash-Dash with anything that can receive HTTP request calls.

The requests that bash-dash makes are by default GET-requests. Optional call-commands that are supplied will be sent as query parameters. The server has at least 2 minutes to send a response, which is then printed in the terminal.

## Upgrade Bash on Mac OS

Unfortunately Mac OS doesn’t provide the latest bash version which may prevent you to take advantage of the latest features that came with bash 4 and 5. Also, running an outdated bash version probably exposes you to some major vulnerabilities.

Mac OS comes with Bash version 3 which is quite limiting and lack key features like the bash associative arrays, improved auto-completion, better Posix conformance, etc.

Follow these steps to upgrade:

### Let's check your version first

```bash
$ bash --version
3.2.53(1)-release
```

### Install Homebrew if you don't have it yet

```bash
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Install latest bash version

```bash
$ brew update && brew install bash
```

### Add new bash version to $PATH

If you run:

```bash
$ which bash
```

It will show you most likely, `/bin/bash`. You might want to add the new bash to your path by editing the `~/.bashrc` or `~/.bash_profile` files, by adding the following line:

```bash
# add to .bash_profile (recommended) or .bashrc
export PATH="/usr/local/bin:$PATH"
```

Now `$ which bash` should give you the Homebrew installation: `/usr/local/bin/bash`. If not, refresh your terminal session or run `$ source ~/.bash_profile` or `$ source ~/.bashrc` and try again.

### Configure terminal to use it

```bash
$ sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
```

if you are using bash as your main shell (you can check via `$ echo $SHELL` if this prints `/bin/bash` you do) you should change to the updated version:

```bash
$ chsh -s /usr/local/bin/bash
```

Now close/refresh you terminal session.

That's it! you can check which bash version you are running via: `$ bash --version`

## License

Bash-Dash is [**Apache 2.0**](https://github.com/n8n-io/bash-dash/blob/main/LICENSE) licensed.

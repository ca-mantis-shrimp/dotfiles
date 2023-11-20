

``` bash
#!/bin/bash
```
# Adding Penv to PATH and making it executible

all we do is use the template script we defined to add the pyenv config once they have it.
``` bash
{{template "bash/pyenv_shell_config.sh" .}}
```


# Adding bob-nvim to the path

We use bob-nvim for our managing Neovim versions, and in order to use the current version of Neovim, we need to add it to our path
``` bash
export PATH="/home/$USER/.local/share/bob/nvim-bin:$PATH"
```
- We are manually appending the absolute path to the binary that is currently selected for bob-nvim, the Neovim version manager
    - Again, this means we need to have bob-nvim already installed on the machine for this to do anything


# Making our OpenAI API Key available

OpenAI is the company behind ChatGPT and other innovative products at the cutting edge of Artificial General Intelligence.
In order to use their API, we need to have an API key, which we store in 1Password.

We will be leveraging Chezmois' template function to read the API key from 1Password and export it as an environment variable.
``` bash
{{- if ne .chezmoi.hostname "USMINDARBURGES1" }}
export OPENAI_API_KEY= op read op://Back-End/openai_api_key/credential
{{- end }}
```
- Add the api key for open AI including ChatGPT and other tools
    - this is going to use the onepassword template for Chezmoi so that we can revoke and change this key should we ever need
    - it also means we effectively have two chained dependencies. Chezmoi for the templating functionality, which is using 1password as the secrets manager

# Making Todoist API Key Available

We are going to do a similar thing for Todoist where we will put the API key behind a Op login so we can have it while still feeling secure in our usage
``` bash
export TODOIST_API_KEY=op read op://Back-End/todoist_api_key/credential

```

# Adding the Cargo and NodeJS version managers

We are going to be using Rust and NodeJS for a lot of the tooling we are going to be installing, so we need to make sure we have the version managers installed for rustup and nvm respectively
      We are going to be using the following tools:
- [Rust](https://rustup.rs/)
- NodeJS:
``` bash
. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

```
- Remember that the `.` at the beginning is equivalent to if we had written the `source` command
    - Therefore, we are effectively sourcing the `.cargo/env` file from the `$HOME` directory
        - This requires that cargo is installed since this is ensuring we make the environment from cargo available to the shell
- Exports nvms' bin via your `.bashrc` automatically after it is installed via the installation script in Linux
    - The line after that loads a shell script that makes nvm available to the system
    - and finally loads bash completions once the first two steps are done so that the application is ready to use out of the box

# Add Personal Bin of shell commands to path

``` bash
export PATH=$PATH":$HOME/bin"
```

# Work Credentials

At the end, we will define some credentials that are only going to be used for work so this will help keep everything up-to-shape

## Work API Tokens

Obviously we are only going to even push these if we are actually running within our work computer as to reduce risk to the firm from my personal machine.
``` bash
{{- if eq .chezmoi.hostname "USMINDARBURGES1" }}
export SNOWMIRROR_USERNAME= op read op://work/SNOWMIRROR/username
export SNOWMIRROR_PASSWORD= op read op://work/SNOWMIRROR_password
export DYNATRACE_EA_PROD_API_KEY= op read op://work/dynatrace_ea_prod_api_key/credential
{{- end }}
```


# Sourcing your .bashrc

as it stands, the bash_profile is the only thing that runs when you login, if you want to ALSO source your bashrc at the same time, you need to add  the following line so you can source the bashrc while we were working
``` bash
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
```

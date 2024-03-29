

 TOC
This is the configuration Neorg Workspace. This Workspace is extra special because it will be the site of an experiment.

We are going to attempt something I have wanted to try but have never felt like I had the tooling required.

Specifically, we are going to leverage the tangling feature of neorg to actually write the various configuration files needed to keep the system running.

We have gotten to the point where the code is rather concise, but it would take allot of context to understand what is going on in each file and how each one connects with the other.

This is where tangling comes in. These neorg files will actually generate the data that we expect to use throught this work.

As far as the structure goes I'm still tinkering with it but for right now I think there will be a norg file for every normal file unless they are rather small so I can ensure that everything is kept tidy

# Index

## Bash

- [Make Wsl_paste Executible](#5cactivatenvimpastewslmd) - 1-line script to make the `nvim_paste_wsl` script executible
- [Bash Commands](#5cbashcommandsmd) - One-Time commands that occasionally need to be run on a new machine
- [Bash Configuration Index](#5cbashconfigmd) - Starting point for configuring the bash shell files
- [Bash Profile](#5cbashprofilemd) - Definition of the .bash_profile
- [Pyenv Installer](#5cinstallpyenvmd) - Smaller script to install pyenv via apt along with dependencies
- [Rust Installer](#5cinstallrustmd) - script to install rust, either in linux or WSL
- [Script Index](#5clinuxscriptsmd) - Index of one-time scripts that need to be run
- [Clipboard Integration For Wsl](#5cnvimpastewslmd) - script to pull clipboard into WSL terminal
- [Profile](#5cprofileconfigmd) - the `.profile` for bash shell
- [Pyenv Shell Configuration Prep](#5cpyenvshellconfigmd) - Some extra steps to get us ready for pyenv

## Index

- [Literate Configuration Directory](#5cindexmd) - Starting Point, Chezmoi Configuration, and Home Directory Files
- [Script Index](#5cscriptsmd) - index of both bash and powershell scripts

## Neovim

- [Config Folder](#5cconfigmd) - Root of the config folder for Neovim
- [Lazy Configuration](#5clazymd) - Configuration for `lazy.nvim`
- [Neorg Configuration](#5cneorgmd) - Configuration of the neorg note taking plugin
- [Configuration Index](#5cneovimmd) - Starting point for Neovim Configuration
- [Options](#5coptionsmd) - Setting options for Neovim itself
- [Plugin Index](#5cpluginsmd) - List of Extra plugins above LazyVim itself
- [Python Plugins](#5cpythontoolsmd) - The plugins needed to make python development possible in neovim
- [Smart Splits Config](#5csmartsplitsmd) - Configuration for the `smart_splits.nvim` plugin
- [Telescope Updates](#5ctelescopemd) - Changes to the LazyVim Telescope Config

## Powershell

- [Profile](#5cpowershellmd) - the bashrc equivalent for powershell
- [Alt Profile](#5cpowershellconfigmd) - Alternative Powershell profile with template support

## Scripts

- [Bash Templates](#5cbashtemplatesmd) - templates for common bash operations

## Wezterm

- [Wezterm](#5cweztermmd) - configuration for wezs' terminal emulator

# [Wezterm Configuration](#weztermmd)


# [Neovim Configuration](#neovimmd)


# [Single-Run Scripts](#scriptsmd)


# Shell Configuration

Here, we are going to walk through any configuration that is needed for the Shell in question, this will likely look largely the same, but with minor tweaks based on the OS or if it is a work machine but should otherwise remain minimal

## [Bash](#bashconfigmd)


## [PowerShell](#powershellconfigmd)


# Chezmoi

Chezmoi is the glue that is holding all of this together, and as such should be understood first only after Neovim itself
  Feel free to review the Chezmoi knowledge itself for further reference, here we are just going to define our chezmoi setup and why we made the decisions we did

## Config File

We are opting to do the standard chezmoi TOML file
``` toml
{{ if eq .chezmoi.os "windows" }}
[cd]
command = "pwsh"
{{ end }}

[diff]
command = "nvim"
args = "-d"

[edit]
command = "nvim"

[git]
autoCommit = true
```
- windows has this annoying thing where it defaults to the cmd for most things so we need to just start it in powershell whenever we use the `chezmoi cd` command
- for the diffing mechanism between chezmoi and the files, I use neovim's default diff mode
    - we do this by running neovim with the `-d` argument
        -  However, in the future I still want to change this over to using the diffview plugin instead to improve the user experience and get them all in one go
- We are using neovim whenever we do `chezmoi edit`
- Finally we have autocommit set to true so that whenever we add a change to our config it autocommits the changes to the repo to make the process of updating the config more seamless

## Ignore File

Another surprisingly import file, since this is one of the main mechanisms we use to control the different configuration variations between the different OSs
``` gitignore
{{ if ne .chezmoi.os "windows" }}
AppData/
Documents/
*.ps1
{{ else }}
dot_ssh/config
dot_config/nvim/
*.sh
bin/
{{ end }}

literate_config/
wiki/
```
- If we are not in windows, we are removing the `AppData`, `Documents`, and all PowerShell files from the `.chezmoiscripts` directory
    - These folders are a microsoft thing, and shouldn't make their way into linux directories
        - specifically, this is where the neovim config and powershell script are respectively.
- Otherwise, we are removing the `nvim` folder from the `.config` file
    - so we don't conflict with the version that is used in windows
- dont forget to ignore this folder! 
    - because it is not intended to be copied to the machine's home directory, it is intended to serve as the brain of the repository itself and thus should never be included
- we have a similar thing going on with the wiki folder. this is intended to be the main point that we use to just represent the exported directory


# Git

The software that has enabled all of this is Chezmoi, a dotfile manager that can give users the ability to have a single configuration with minor edits to accomodate different OSs as well as different needs for different machines.

While this wont be the main place we talk about the inner workings of Chezmoi, I will leave that to the [Chezmoi Knowledge Files](#knowledgebaseapplicationschezmoiindexmd)

Instead, here we are going to define our chezmoi files and explain why we have made the decisions we did

Our git configuration file is one of the first places where we start leveraging the template abilities of chezmoi:
``` gitconfig
[user]
{{- if eq .chezmoi.hostname "USMINDARBURGES1" }}
email = darburgess@deloitte.com
{{ else }}
email = dargondab9@gmail.com
{{- end }}
name = Darrion Burgess

[core]
symlinks = true

[credential]
{{- if eq .chezmoi.os "windows" }}
helper = C:/Program\\ Files/Git/mingw64/bin/git-credential-manager
{{- else }}
helper = /mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe
{{- end}}
```
- The main variation comes with the email that gets set for the git pieces
    - the work one just changes the email to my standard work email
    - While any other time we use the standard email associated with our personal GH account
- Finally, we are using gits' built-in credential storing feature to store our PAT tokens within the local machine
    - While it is generally considered bad-practice to store secret in plaintext in a repo, we have avoided that in the credential file itself by outsourcing this work to the 1password CLI which you will see below
- finally we need to put in this symlinks option to make this symlink hack we are relying on work between windows and linux per [This discussion about symlinks between linux and windows](https://stackoverflow.com/questions/5917249/git-symbolic-links-in-windows/59761201#59761201)
- we also also make openSSH our agent on windows per [This 1password tutorial](https://developer.1password.com/docs/ssh/get-started)

## Git Credentials Using PAT Tokens

PAT Tokens are the recommended way to get this stuff done.
  we are going to use 1Password to get this all going but we are just trying to make this all work

# Docker 

One of the primary changes that have been made over this time is the need to control one level above and handle the docker work that is required to ensure an actally working environment. 

Specifically, we are going to have two separate containers:
- The presentation container
    - used to present the wiki



This is primarily around setting up powershell properly in such a way that we are able to set up a local environment without much fuss and without feeling like we have to rebuild it each time.


# Set shell environment variable to powershell

By default, windows 10 uses the legacy `cmd` program to maintain legacy support for systems.

This can only be seen when we create a sub-shell, either through neovim or some other medium.

However, when we do, we always want to use powershell and the best way to do that is to set an environment variable called `$SHELL` that tells windows which shell to use
``` pwsh
$env:SHELL="pwsh"
```


# Export Environment variables

``` pwsh
{{- if ne .chezmoi.hostname "USMINDARBURGES1" }}
$env:OPENAI_API_KEY= op read op://Back-End/openai_api_key/credential
{{- end }}

$env:TODOIST_API_KEY = op read op://Back-End/todoist_api_key/credential
```
- just using the onepassword CLI to actually pull the credentials themselves
    - remember, this assumes you have already set your service account key BEFORE running chezmoi
- we are now also ensuring we dont use open api stuff when we arent on the proper computer for work

# Setup Starship Prompt

Primary thing we are doing right now is setting up starship prompt, while it is relatively straightforward, we need to be careful that we dont just update shit without thinking about it.

Specifically, this should always be the last thing we do since this is only meant to be activated for the user and can be messed up if other stuff happens afterwards

``` pwsh
Invoke-Expression (&starship init powershell)
```



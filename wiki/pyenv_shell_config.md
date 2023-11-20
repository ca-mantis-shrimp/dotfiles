

For pyenv, we need to set a few things up before it becomes usable within the environment.

However, we need to do this in a few files to ensure this is captured from the right perspective

To that end, we will be leaving this in a separate file so that we are able to reference it externally within other scripts
``` bash
export PYENV_ROOT="$HOME/.pyenv"

command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init -)"
```

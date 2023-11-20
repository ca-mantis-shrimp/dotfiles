

``` bash
#!/bin/bash
```

all we do is use the template script we defined to add the pyenv config once they have it.
``` bash
{{template "bash/pyenv_shell_config.sh" .}}
```

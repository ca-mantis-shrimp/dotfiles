

Bash should be relatively straightforward, with the exception of my custom prompt and adding some things to the path
``` bash
#!/bin/bash
```
- just standard bash starting point, nothing strange so far hopefully

# [Templates](#bashtemplatesmd)


# [Profile Config](#profileconfigmd)


# [Bash Profile Config](#bashprofilemd)


# [Bash Commands](#bashcommandsmd)


# Enable Starship Prompt

Lastly, we will enable the starship prompt, this is a nice prompt that is highly customizable and has a lot of nice features
``` bash
eval "$(starship init bash)"
```
- We have the evaluation of the starship prompt
    - This requires that the startship prompt is already installed on the system
- must be enabled last otherwise we start getting strange errors around not being able to call the starship command 

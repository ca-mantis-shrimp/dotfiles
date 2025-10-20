---
title: Standard agents.md file
description: The standard Agents.md file to instruct LLMs how to interact with the repo
author: primary_desktop
categories: LLM
created: 2025-09-01T20:19:39-0800
updated: 2025-09-01T20:47:25-0800
version: 1.1.1
---
# Chezmoi Config

## Editing Literate Config

- ALWAYS edit `.norg` files in the `literate_config` folder, NEVER edit source files directly
- ALWAYS explain your changes within the norg file
- ONLY tangle if you made code changes
- ALWAYS regenerate the index if you moved, or deleted a literate config file
- ONLY make modifications if you are sure, ALWAYS ask for clarification
- NEVER respond just to make me happy, ALWAYS try to point out lapses in reasoning unless it gets in the way of delivery


### Examples

to generate the workspace index do the following:
```bash
nvim literate_config/index.norg
:10
:Neorg generate-workspace-summary
```

#### adding, modify literate_config files

check for updates with `chezmoi update`
To tangle the code:
```bash
nvim <file>.norg
:Neorg tangle current-file
```

if you end up making or editing a fennel file, do the following after you tangle:
```bash
nvim .chezmoitemplates/neovim/<filename>.fnl
:s
:e %:r.lua
:s
```

Finally, if this is for neovim we need to check two places for templates files:
- AppData/Local/nvim/.....
- and dot_config/remove_nvim/....

inside, there should be a file for each file we have in the templates directory of the name `filename.lua.tmpl` with the following line:
```bash
{{-. template .neovim/filename.lua .-}}
```
to ensure it REFERENCES the generate lua files


## Testing functionality

we can test with:
```bash
chezmoi apply --dry-run --verbose
chezmoi apply
```


## Style

NO comments in the code blocks, ALL commentary should be within the norg files
but within those files we are explaining the WHY around our decisions, not necesarily what is going on

the work

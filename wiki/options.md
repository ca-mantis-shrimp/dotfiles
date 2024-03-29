

LazyVim actually has its' own set of options setup, you can check in the lazyvim repo itself.
These options are loaded AFTER both the lazyvim options, and the plugin options, meaning they will be the ones that win-out since lua is a scripted language
``` lua
vim.opt.autochdir = true

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
```
- A bunch of tools seem to work better when I just automatically cd into the directory including neorg, config files, and python
- Next we use these two options in tandem to fold our code using treesitter rather than the normal folding methods
    - first, we set the method of determining folds as an expression
    - next is the expression to be used
        - specifically, we are using the `foldexpr` function for the treesitter repo itself
            - Therefore, this should work for any file which you have treesitter installed and enabled

# GUI Options

Neovide and other GUI applications have their own options within Neovim that allow us to have an easy API to handle the GUI-related operations all at once.

``` lua
vim.o.guifont = "FiraCode NF:h20"
```
- the sets the `guifont` option for Neovim to the Nerd-Font-enabled version of Fira Code at size 24


## Changing Font Sizes from Neovide

Neovide itself has a few options that we want to enable so we can give ourselves a good editing experience if and when we decide to full-time this as our main GUI environment for Neovim.

Specifically, we need to rely on the `neovide_scale_factor` option to increase and decrease font size at during runtime. Rather than the standard format of simply changing the font size for the terminal since there is no longer a terminal to check!

``` lua
vim.g.neovide_scale_factor = 1.0

local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

vim.keymap.set("n", "<C-=>", function()
  change_scale_factor(1.25)
end)
vim.keymap.set("n", "<C-->", function()
  change_scale_factor(1/1.25)
end)
vim.keymap.set("n", "<C-[>", function()
  vim.g.neovide_scale_factor = 1.0
end)
```
1. We set the global Neovide scaling option to just be 1-1 with the standard scaling factor
2. We define a function which takes an integer as the delta and multiplies it by the current scaling factor
3. We then set the keymaps to increase and decrease the scaling factor by 25% each time
4. We also set a keymap to reset the scaling factor to 1.0


# Python Provider Virtual Env

Python has a special provider that gives (Neo)vim the ability to define and use python plugins.

while we arent too interested in the python provider itself, the settings defined here are used for other important tools like mason.nvim, LSP, and all the functionality around virtual environments

so here we have the single line in which we set the actual piece:
``` lua
if vim.fn.has("windows") then
  vim.g.python_host_prog = vim.fn.expand('$HOME/python_virtual_environments/dev3.12.0/Scripts/python')
  vim.g.python3_host_prog = vim.fn.expand('$HOME/python_virtual_environments/dev3.12.0/Scripts/python')
else
  vim.g.python_host_prog = vim.fn.expand('$HOME/.pyenv/versions/3.12.0/envs/dev3.12.0/bin/python')
  vim.g.python3_host_prog = vim.fn.expand('$HOME/.pyenv/versions/3.12.0/envs/dev3.12.0/bin/python')
end
```
- the `python3_host_prog` setting will choose the python executible (and more importantly, the virtual environment) that will be used to create this work
- we use the `vim.fn.expand` to easily create a path that starts with an environment variable
- the rest of the line is the hard-coded path to the virtual environment we plan to use to develop our projects
- another note is on the if block, unfortunately, the windows equivalent of pyenv does not support integrated virtual environments, so instead, we need to create a new folder for our virtual environments where we will manually make, and update that virtual environments based on the need
    - Otherwise, we use the integrated pyenv virtual environment as our host python program whenever we are in not windows(linux)



The Config folder can be found within our configs' `lua` folder, and is used by LazyVim to configure the editor after the initial plugins have been loaded and configured
From there, we have a few key files that are used to configure neovim through different means

# [Lazy Config](#lazymd)


# [Setting Options](#optionsmd)


# Auto Commands

Autocmds are automatically loaded on the VeryLazy event
[Default autocmds that are always set](https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua)

## Options for Prose Writing

We wrap and check for spell in text file types (currently just norg files)
``` lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "norg" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt.spelllang = { "en_us" }
  end,
})

```
- Here we are just creating an Auto Command that will check the Filetype for certain patterns and do something if it finds the appropriate ones
    - in this case, we are setting some important options that are necessary for writing prose in neovim
        - wrap makes the words wrap when the hit the other side of the screen instead of just going on
        - spell ensures that we are checking spelling in prose files where it is relevant
            - and for that spelling we will be using the US English Spelling dictionary loaded in memory



Plugins are what really makes Neovim special, and here we can explore the magic (and frustration) of using plugins created for Neovim by the community

I think to start, I am just going to start with the smaller stuff and then work through it one at a time. Especially large plugins will likely get their own file so I can decouple them from what I have to do with the others which can be generated all at once

# [Neorg configuration](#neorgmd)


# [Telescope Config](#telescopemd)


# [Smart Splits Config](#smartsplitsmd)


# [Python Tools](#pythontoolsmd)


# Opening the Plugin File

First, we just need to remember that lazy expects a table of tables so we start by opening the return table from which all other table with be contained.
``` lua
return {
```

# Portal Configuration

Portal is an interesting little plugin that enables us to visualize the jumplist before you just jump there.
``` lua
{
  "cbochs/portal.nvim",
  dependencies = { "cbochs/grapple.nvim" },
  keys = {
    { "<leader>o", "<cmd>Portal jumplist backward<cr>" },
    { "<leader>i", "<cmd>Portal jumplist forward<cr>" },
  },
},
```
- [grapple.nvim](https://github.com/cbochs/grapple.nvim/tree/ab274a3bfb674442d57fca05df866b71895853bc) serves as the core library that allows for this file list and enable the preview capabilities
- Otherwise, the plugin is only loaded when you use either of the keybinds above
    - we chose `leader`o and i because it mirrors the normal jumplist hotkeys to express that they are paralell but different features

# Noice

[noice.nvim](https://github.com/folke/noice.nvim) is a super interesting, experimental plugin that was made by our resident hero folke.

This plugin does many things, but chief among them is:
- Introduction of great notifications via noice.nvim
- Replacing command lines with a new popup format
- and a bunch of other little things that make neovim really feel like an editor from the twenty first century

``` lua
{
  "folke/noice.nvim",
  cond = not vim.g.started_by_firenvim,
},
```

# Git Diff

The standard diff view for Neovim is fine, but it leaves a few things to be desired.
- It doesn't feel like a really integrated solution with the ability to show the context
- More importantly, it can't show multiple files easily making the process of reviewing diffs for multiple files (as if often the case when we do `chezmoi apply`), then it can make the process feel cumbersome
``` lua
{
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
},
```

# Chezmoi Support

Chezmoi has a bunch of strange files so this (rather old) plugin justt ries to smooth over the rough edges by properly highlighting these files and whatnot.
``` lua
{
  "alker0/chezmoi.vim",
},
```

# ChatGPT

ChatGPT can be configured with a specific plugin someone made to engage with the 3.5 model
``` lua
{
  "jackMort/ChatGPT.nvim",
  config = function() 
    require('chatgpt').setup()
  end,
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
},
```
- we use nui and plenary to make it look good
- while telescope is used as the menu that we primarily integrate with

# Running Rest Commands

I'm going to be doing more rest development work so I would like to be able to run rest calls from within the editor so i don't need to rely on tools like postman or stuff like that.
  For this we are going to be using [rest.nvim] which is a plugin that allows you to run rest commands from within Neovim.
  Nothing super interesting here, we pull in the plugin and for now just use the standard config.
``` lua
{
  "rest-nvim/rest.nvim",
  dependencies = {"nvim-lua/plenary.nvim"},
  config = true,
  ft = "http",
  keys = {
    {"<leader>rc", "<cmd>RestNvim<cr>", "run request under the cursor"},
    {"<leader>rp", "<cmd>RestNvimPreview<cr>", "Preview Request Curl Command"},
    {"<leader>rl", "<cmd>RestNvimLast<cr>", "re-run the last request"},

  }
},
```

# [Code Minimap](https://github.com/wfxr/minimap.vim/tree/726746ed02eab2eef137a7ecceda7214fbeeec41)

In an attempt to get something close to what VSCode has, I am trying
``` lua
{
  "wfxr/minimap.vim",
  keys = { { "leader>um", "<cmd>MinimapToggle<cr>", desc = "Toggle Minimap" } },
  build = "cargo install --locked code-minimap",
  lazy = false,
},
```

# Adding Support for PlantUML

We are going to use the [PlantUML Syntax File](https://github.com/aklt/plantuml-syntax) to actually work with PlantUML files:
``` lua
{
  "weirongxu/plantuml-previewer.vim",
  dependencies = {"aklt/plantuml-syntax", "tyru/open-browser.vim"},
},
```
  This is going to just enable syntax highlighting for the various plantuml files while also giving us the ability to create graphviz files from these files in the future

# Color Schemes

We are going to try and put all of the color schemes into a single file to reduce the amount of breakage we get from adding new things

``` lua
{"projekt0n/github-nvim-theme"},
```
- we have the GitHub theme because I am hoping to finally get a good light theme since this apartment makes it much harder to leverage the dark themes when compared to the setups I have had before

# Filetype Plugins

Neo(Vim) includes support for several languages out-of-the-box, but ofcourse, it can't support everything, and for other languages, teams and individuals are able to create much more refined experiences when compared to basic syntax highlighting. This file is where we will store many of the small plugins which are primarily intended to support specific filetypes.

``` lua
{
  'cameron-wags/rainbow_csv.nvim',
  config = true,
  ft = {
    'csv',
    'tsv',
    'csv_semicolon',
    'csv_whitespace',
    'csv_pipe',
    'rfc_csv',
    'rfc_semicolon'
  },
  cmd = {
    'RainbowDelim',
    'RainbowDelimSimple',
    'RainbowDelimQuoted',
    'RainbowMultiDelim'
  }
},
```


# Ending the plugin spec

Finally, we end the plugin spec so everything is contained as a single table and we finish the piece we started with
``` lua
}
```

# Plugin List

Links
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
- [portal.nvim](https://github.com/cbochs/portal.nvim)
- [Noice.nvim](https://github.com/folke/noice.nvim)
- [lsp_lines.nvim](https://github.com/ErichDonGubler/lsp_lines.nvim/tree/3b57922d2d79762e6baedaf9d66d8ba71f822816)
- [diffview.nvim](https://github.com/sindrets/diffview.nvim)
- [chezmoi.vim](https://github.com/alker0/chezmoi.vim)
- [neotest](https://github.com/nvim-neotest/neotest)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [ChatGPT.nvim](https://github.com/jackMort/ChatGPT.nvim)
- [rest.nvim](https://github.com/rest-nvim/rest.nvim)
- [symbols-outline.nvim](https://github.com/simrat39/symbols-outline.nvim)


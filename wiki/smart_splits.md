

We are also implementing smart splits, which implements a much more intuitive, coherent strategy for updating and changing split focus and sizing of different splits.

The part where this goes from cool to mindblowing is its support for multiplexers so that we can ensure these split hotkeys are applicable whether or not we are in neovim
- this includes support for wezterm! so I'm super excited to see this coming because this will help us really have the tmux-like experience that linux users have had for years.

# Base Config

``` lua
local smart_splits_config = {
  "mrjones2014/smart-splits.nvim",
  config = true,
}

```
- the only thing we are doing is design


## Keymaps

here we have to define not just the plugin, but the keymaps that will be used for it.
- I could potentially use any of these first, so I will just put all of them in the keys table so that any one of them could be used to activate the plugin
- Do note, we must encase all of the functions within a function call because we need this to be a callback, aka, we need to this be called AFTER the plugin is loaded since we will be utilizing functions that are not available until then
    - without this we run into the dreaded "no plugin found" error even though we have clearly downloaded the plugin
    - in addition, functions called this way must have an explicit `()` call at the end, since the functions are not evaluated until we are look at them and otherwise we still get an error whereas the readme is able to refer to them without using those function signs
      This is my first attempt at doing the config as a separate table and returning it distinctly but this allow me to actually follow the step-down principle of defining the most important bits of code first, followed by other methods
      We are taking the config table defined above and setting the keys index to the table defined, if done well, this should enable us to define the config iteratively rather than needing to construct it all at once
``` lua
smart_splits_config.keys = {}

```
- in even more of a reversal I am actually going to just make an empty keys table and insert the keymaps into them one-by-one

### Resize Keymaps

First we are going to resize our current window/pane with the `ALT` Modifier
``` lua
table.insert(smart_splits_config.keys,{
  "<A-h>",
  function()
    require("smart-splits").resize_left()
  end,
  desc = "Resize Split Left",
})
table.insert(smart_splits_config.keys,{
  "<A-j>",
  function()
    require("smart-splits").resize_down()
  end,
  desc = "Resize Split Down",
})
table.insert(smart_splits_config.keys,{
  "<A-k>",
  function()
    require("smart-splits").resize_up()
  end,
  desc = "Resize Split Up",
})
table.insert(smart_splits_config.keys,{
  "<A-l>",
  function()
    require("smart-splits").resize_right()
  end,
  desc = "Resize Split Right",
})

```

### Move Focused Window Keymaps

Now we will add keymaps to change our current focus when it comes to a window so that we can just use `CNTRL`+direction key to actually just move the focus to the closest directional windows/pane
``` lua
table.insert(smart_splits_config.keys,{
  "<C-h>",
  function()
    require("smart-splits").move_cursor_left()
  end,
  desc = "Move To Split on the Left",
})
table.insert(smart_splits_config.keys,{
  "<C-j>",
  function()
    require("smart-splits").move_cursor_down()
  end,
  desc = "Move To Split Below Current",
})
table.insert(smart_splits_config.keys,{
  "<C-k>",
  function()
    require("smart-splits").move_cursor_up()
  end,
  desc = "Move To Split Above Current",
})
table.insert(smart_splits_config.keys,{
  "<C-l>",
  function()
    require("smart-splits").move_cursor_right()
  end,
  desc = "Move To Split on the Right",
})

```

### Swapping Windows Keymaps

Finally we have some keymaps behind the leader hotkeys' window subcommand to swap the currently focused window with the window in the defined direction
- it should be noted this will be the only set of hotkeys likely not getting into the wezterm part initially only because idk if wezterm has implemented the swap feature yet
``` lua
table.insert(smart_splits_config.keys,{
  "<<leader><leader>-h>",
  function()
    require("smart-splits").swap_buf_left()
  end,
  desc = "Swap With Window on Left",
})
table.insert(smart_splits_config.keys,{
  "<<leader><leader>-j>",
  function()
    require("smart-splits").swap_buf_down()
  end,
  desc = "Swap With Window Below",
})
table.insert(smart_splits_config.keys,{
  "<<leader><leader>-k>",
  function()
    require("smart-splits").swap_buf_up()
  end,
  desc = "Swap With Window Above",
})
table.insert(smart_splits_config.keys,{
  "<<leader><leader>-l>",
  function()
    require("smart-splits").swap_buf_right()
  end,
  desc = "Swap With Window on Right",
})

```
  --
``` lua
return smart_splits_config
```
- Finally, we return the config object defined at the beginning, and if all goes well, this should hold all of the proper logic without needing a rework or running into errors

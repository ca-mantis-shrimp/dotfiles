local smart_splits_config = {
  "mrjones2014/smart-splits.nvim",
  config = true,
}


smart_splits_config.keys = {}


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


return smart_splits_config
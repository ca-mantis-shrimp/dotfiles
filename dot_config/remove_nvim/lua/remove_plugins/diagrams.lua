-- [nfnl] dot_config/remove_nvim/lua/remove_plugins/diagrams.fnl
local function _1_()
  return require("mermaider"):setup({mermaider_cmd = "npx -y -p @mermaid-js/mermaid-cli mmdc -i {{IN_FILE}} -o {{OUT_FILE}}.png -s 3", temp_dir = vim.fn.expand("$HOME/.cache/mermaider"), auto_render = true, auto_render_on_open = true, auto_preview = true, theme = "forest", background_color = "#1e1e2e", mmdc_options = "", max_width_window_percentage = 80, max_height_window_percentage = 80, inline_render = true, use_split = true, split_direction = "vertical", split_width = 50})
end
return {"snrogers/mermaider.nvim", dependencies = {"3rd/image.nvim"}, config = _1_, ft = {"mmd", "mermaid"}}

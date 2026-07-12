-- Build step compiles the tokenizer — run make after install/update
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if name ~= "avante.nvim" or (kind ~= "install" and kind ~= "update") then
      return
    end
    local path = vim.fn.stdpath("data") .. "/site/pack/core/opt/avante.nvim"
    vim.system({ "make" }, { cwd = path }, function(result)
      if result.code ~= 0 then
        vim.notify("avante.nvim build failed:\n" .. result.stderr, vim.log.levels.ERROR)
      end
    end)
  end,
})

vim.pack.add({
  "https://github.com/yetone/avante.nvim",
  "https://github.com/HakonHarnes/img-clip.nvim",
})

require("img-clip").setup({
  default = {
    embed_image_as_base64 = false,
    prompt_for_file_name = false,
    drag_and_drop = { insert_mode = true },
  },
})

require("avante").setup({
  input = { provider = "snacks" },
  provider = "claude",
  providers = {
    claude = {
      model = "claude-sonnet-4-20250514",
      auth_type = "max",
      extra_request_body = {
        max_tokens = 20480,
      },
    },
  },
  -- evaluated per-message so avante always sees current MCP server state
  system_prompt = function()
    local hub = require("mcphub").get_hub_instance()
    return hub and hub:get_active_servers_prompt() or ""
  end,
  custom_tools = function()
    return { require("mcphub.extensions.avante").mcp_tool() }
  end,
})

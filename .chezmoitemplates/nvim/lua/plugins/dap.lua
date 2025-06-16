-- [nfnl] lua/plugins/dap.fnl
local function _1_()
	local dap = require("dap")
	local dapui = require("dapui")
	local virtual_text = require("nvim-dap-virtual-text")
	dapui.setup()
	virtual_text.setup()
	local function _2_()
		return dapui.open()
	end
	dap.listeners.after.event_initialized.dapui_config(_2_)
	local function _3_()
		return dapui.close()
	end
	dap.listeners.before.event_terminated.dapui_config(_3_)
	local function _4_()
		return dapui.close()
	end
	dap.listeners.before.event_exited.dapui_config(_4_)
	dap.adapters.codelldb =
		{ type = "server", port = "${port}", executable = { command = "codelldb", args = { "--port", "${port}" } } }
	local function _5_()
		return _G.vim.fn.input("Path to executable: ", (_G.vim.fn.getcwd() .. "/target/debug/"), "file")
	end
	local function _6_()
		return tonumber(_G.vim.fn.input("Process ID: "))
	end
	dap.configurations.rust = {
		{
			name = "Launch",
			type = "codelldb",
			request = "launch",
			program = _5_,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
		},
		{ name = "Attach to process", type = "codelldb", request = "attach", pid = _6_ },
	}
	local map = _G.vim.keymap.set
	map("n", "<F5>", dap.continue, { desc = "DAP Continue" })
	map("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
	map("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
	map("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })
	map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
	local function _7_()
		return dap.set_breakpoint(_G.vim.fn.input("Breakpoint condition: "))
	end
	map("n", "<leader>dB", _7_, { desc = "DAP Conditional Breakpoint" })
	map("n", "<leader>dr", dap.repl.open, { desc = "DAP Open REPL" })
	map("n", "<leader>dl", dap.run_last, { desc = "DAP Run Last" })
	return map("n", "<leader>du", dapui.toggle, { desc = "DAP Toggle UI" })
end
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = { "rcarriga/nvim-dap-ui", "theHamsta/nvim-dap-virtual-text", "nvim-neotest/nvim-nio" },
		config = _1_,
	},
}

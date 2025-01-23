return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		terminal = {
			enabled = true,
		},
		dim = { enabled = true },
		-- bigfile = { enabled = true },
		-- dashboard = { enabled = true },
		-- indent = { enabled = true },
		-- input = { enabled = true },
		-- quickfile = { enabled = true },
		-- scroll = { enabled = true },
		-- statuscolumn = { enabled = true },
		-- words = { enabled = true },
	},
	keys = {
		{
			"<leader>ns",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification History",
		},
		{
			"<A-h>",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle Terminal",
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				Snacks.toggle.dim():map("<leader>uD")
			end,
		})
	end,
}

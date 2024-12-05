return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			--lspconfig.ts_ls.setup({})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "[User] LSP Hover"})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[User] LSP Definition" })
			vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[User] LSP Code Action" })
		end,
	},
}

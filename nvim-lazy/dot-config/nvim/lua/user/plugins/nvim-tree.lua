return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			view = {
				width = 35,
				relativenumber = true,
			},
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							-- arrow_closed = "", -- arrow when folder is closed
							-- arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer" }) -- toggle file explorer
		keymap.set("n", "<leader>ex", "<cmd>NvimTreeClose<CR>", { desc = "Close file explorer" }) -- toggle file explorer
		keymap.set("n", "<leader>e+", "<cmd>NvimTreeResize +10<CR>", { desc = "Increase file explorer size" }) -- toggle file explorer
		keymap.set("n", "<leader>e-", "<cmd>NvimTreeResize -10<CR>", { desc = "Decrease file explorer size" }) -- toggle file explorer
	end,
}

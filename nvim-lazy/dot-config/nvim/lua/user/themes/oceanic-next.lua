return {
	{
		"mhartington/oceanic-next",
		priority = 1000,
		config = function()
			require("oceanic-next").setup()
			vim.cmd([[colorscheme OceanicNext]])
		end,
	},
}

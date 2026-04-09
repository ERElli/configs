return {
	{
		"rose-pine/neovim",
		lazy = false,
		name = "rose-pine",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("rose-pine-moon")
		end
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato",
				background = {
					dark = "macchiato",
					light = "frappe",
				},
			})
		end,
	},
	{
		'olivercederborg/poimandres.nvim',
		name = "poimandres",
		config = function()
			require('poimandres').setup({})
		end,
	},
}

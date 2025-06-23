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
		lazy = false,
		name = "catppuccin",
		priority = 1000,
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
		lazy = false,
		name = "poimandres",
		priority = 1000,
		config = function()
			require('poimandres').setup({})
		end,
	},
}

return {
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
			vim.cmd.colorscheme("catppuccin")
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
		init = function()
			vim.cmd.colorscheme("poimandres")
		end,
	}
}

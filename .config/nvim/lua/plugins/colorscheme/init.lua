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
					light = "frappee"
				},
			})
			vim.cmd.colorscheme "catppuccin"
		end,
	},
}

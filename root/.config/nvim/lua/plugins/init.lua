return {
	"nvim-lua/plenary.nvim",
	{
		"karb94/neoscroll.nvim",
		event = "VeryLazy",
		config = function ()
			require('neoscroll').setup({})
		end
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		config = true,
		keys = {
			{
				"<leader>tf",
				"<cmd>ToggleTerm direction='float'<cr>",
				desc = "float terminal"
			},
			{
				"<leader>tt",
				"<cmd>ToggleTerm direction='horizontal'<cr>",
				desc = "terminal"
			}
		}
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"},
		opts = {}
	},
}

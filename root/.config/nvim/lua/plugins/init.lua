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
				"<leader>tt",
				"<cmd>ToggleTerm direction='float'<cr>",
				desc = "float terminal"
			}

		}
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"},
		opts = {}
	}
}

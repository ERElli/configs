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
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		opts = {
			toggler = {
				line = "<leader>cl",
				block = "<leader>cb",
			},
			opleader = {
				line = "<leader>cl",
				block = "<leader>cb",
			},
		},
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"},
		opts = {}
	}
}

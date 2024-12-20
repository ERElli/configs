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
		"pmizio/typescript-tools.nvim",
		dependencies = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"},
		opts = {}
	}
}

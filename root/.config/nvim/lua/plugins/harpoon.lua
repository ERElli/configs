return {
	"ThePrimeagen/harpoon",
	lazy = false,
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("harpoon"):setup({})
	end,
	keys = {
		{
			"<leader>hl",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "List marked files",
		},
		{
			"<leader>hm",
			function()
				require("harpoon"):list():add()
			end,
			desc = "Mark file with harpoon",
		},
		{
			"<leader>hn",
			function()
				require("harpoon"):list():next()
			end,
			desc = "Go to next harpoon mark",
		},
		{
			"<leader>hp",
			function()
				require("harpoon"):list():prev()
			end,
			desc = "Go to previous harpoon mark",
		},
	},
}

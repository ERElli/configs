return {
	"ThePrimeagen/harpoon",
	lazy = false,
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local harpoon = require("harpoon");
		harpoon:setup({})
		vim.keymap.set("n", "<leader>hg", function() harpoon:list():select(1) end, {desc="Switch to first harpoon item"})
		vim.keymap.set("n", "<leader>hh", function() harpoon:list():select(2) end, {desc="Switch to second harpoon item"})
		vim.keymap.set("n", "<leader>hj", function() harpoon:list():select(3) end, {desc="Switch to third harpoon item"})
		vim.keymap.set("n", "<leader>hk", function() harpoon:list():select(4) end, {desc="Switch to fourth harpoon item"})
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

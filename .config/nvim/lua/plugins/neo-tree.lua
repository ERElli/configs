return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require('neo-tree').setup({
			close_if_last_window = true,
		})
	end,
	keys = {
		{
			"<leader>be",
			function()
				require("neo-tree.command").execute({ source = "buffers", toggle = true })
			end,
			desc = "Buffer Explorer",
		},
		{
			"<leader>fe",
			function()
				require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
			end,
			desc = "Explorer NeoTree",
		},
	},
}

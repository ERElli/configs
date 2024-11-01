return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	opts = function()
		return {
			event_handlers = {
				{
					event = "neo_tree_buffer_enter",
					handler = function()
						vim.opt_local.relativenumber = true
					end,
				}
			},
			window = {
				auto_expand_width = true,
			}
		}
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
				require("neo-tree.command").execute({ dir = vim.loop.cwd(), position = 'right', toggle = true })
			end,
			desc = "Explorer NeoTree",
		},
		{
			"<leader>fr",
			function()
				require("neo-tree.command").execute({ dir = vim.loop.cwd(), position = 'right', toggle = true, reveal = true })
			end,
			desc = "Open NeoTree with focus on current file"
		},
	},
}

return {
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {},
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- 	keys={
	-- 		{
	-- 			"<leader>nd",
	-- 			"<cmd>Noice dismiss<cr>",
	-- 			desc="Dismiss Noice notifications",
	-- 		}
	-- 	}
	-- },
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local hooks = require("ibl.hooks");
			local highlight = {
				"RainbowRed",
				"RainbowOrange",
				"RainbowYellow",
				"RainbowGreen",
				"RainbowBlue",
				"RainbowViolet",
				"RainbowCyan",
			}

			hooks.register(
				hooks.type.HIGHLIGHT_SETUP, function()
					vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
					vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
					vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
					vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
					vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
					vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
					vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
				end
			)
			vim.g.rainbow_delimiters = { highlight = highlight }

			require("ibl").setup({
				indent = {
					char = "│",
					tab_char = "│",
				},
				scope = {
					highlight = highlight,
					enabled = true,
					show_start = true,
					show_end = true,
				},
				exclude = {
					filetypes = {
						"help",
						"alpha",
						"dashboard",
						"neo-tree",
						"Trouble",
						"trouble",
						"lazy",
						"mason",
						"notify",
						"toggleterm",
						"lazyterm",
					},
				},
			})

			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
		main = "ibl",
	},
	{
		'stevearc/dressing.nvim',
		event = "VeryLazy"
	},
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"HiPhish/rainbow-delimiters.nvim",
			"nvim-treesitter/nvim-treesitter-textobjects"
		},
		build = ":TSUpdate",
		event = "BufReadPost",
		config = function()
			local swap_next, swap_prev = (function()
				local swap_objects = {
					p = "@parameter.inner",
					f = "@function.outer",
					c = "@class.outer",
				}

				local n, p = {}, {}
				for key, obj in pairs(swap_objects) do
					n[string.format("<leader>cx%s", key)] = obj
					p[string.format("<leader>cX%s", key)] = obj
				end

				return n, p
			end)()

			require("nvim-treesitter.configs").setup {
				auto_install = true,
				ensure_installed = {
					"bash",
					"html",
					"dockerfile",
					"graphql",
					"gitignore",
					"javascript",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"query",
					"regex",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
					"yaml",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true, disable = { "python" } },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "grn",
						scope_incremental = "grc",
						node_decremental = "grm",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["aa"] = "@paramater.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[M"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
					swap = {
						enable = true,
						swap_next = swap_next,
						swap_previous = swap_prev
					},
				},
			}
		end,
	},
}


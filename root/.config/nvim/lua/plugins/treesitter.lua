return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"HiPhish/rainbow-delimiters.nvim",
			"nvim-treesitter/nvim-treesitter-textobjects"
		},
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		-- lazy = false,
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

			vim.g.skip_ts_context_commentstring_module = true

			vim.g.nvim_treesitter = {
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
					"starlark",
				},
				sync_install = false,
			}

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
				end,
			})

			require("nvim-treesitter-textobjects").setup {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["aa"] = "@parameter.outer",
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
						["[m"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = swap_next,
					swap_previous = swap_prev
				},
			}
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPost",
		opts = {
			enable = true,
			max_lines = 0,
			mode = "cursor",
			separator = " ",
		},
		config = function(_, opts)
			require("treesitter-context").setup(opts)
		end,
	},
}


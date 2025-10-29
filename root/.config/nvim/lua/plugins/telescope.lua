return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		"nvim-telescope/telescope-ui-select.nvim",
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_fond },
	},
	config = function()
		local telescope = require('telescope')
		local actions = require('telescope.actions')
		local action_state = require('telescope.actions.state')

		local delete_buffer = function(prompt_bufnr)
			local current_picker = action_state.get_current_picker(prompt_bufnr)
			local multi_selections = current_picker:get_multi_selection()

			if next(multi_selections) == nil then
				actions.select_default(prompt_bufnr)
				vim.cmd('bdelete')
			else
				actions.close(prompt_bufnr)
				for _, selection in ipairs(multi_selections) do
					vim.api.nvim_buf_delete(selection.bufnr, {force = false})
				end
			end
		end

		local open_multiple_buffers = function(prompt_bufnr)
			local current_picker = action_state.get_current_picker(prompt_bufnr)
			local multi_selections = current_picker:get_multi_selection()
			
			if next(multi_selections) == nil then
				-- If no multi-selection, just open the current selection
				actions.select_default(prompt_bufnr)
			else
				-- Close telescope first
				actions.close(prompt_bufnr)
				-- Open each selected file in a buffer and add to harpoon
				for _, selection in ipairs(multi_selections) do
					local filename = selection.path or selection.filename
					vim.cmd('edit ' .. filename)
					
					-- Jump to the line if available (for grep results)
					if selection.lnum then
						vim.api.nvim_win_set_cursor(0, {selection.lnum, selection.col or 0})
					end
					
					-- Add to harpoon2 list
					if pcall(require, 'harpoon') then
						local harpoon = require('harpoon')
						harpoon:list():add()
					end
				end
			end
		end

		
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-d>"] = delete_buffer,
						["<C-o>"] = open_multiple_buffers,
					},
					n = {
						["dd"] = delete_buffer,
						["<Tab>"] = actions.toggle_selection,
						["<CR>"] = open_multiple_buffers,
						["o"] = open_multiple_buffers,
					}
				},
			},
			pickers = {
				buffers = {
					sort_lastused = true,
					sort_mru = true,
					mappings = {
						i = {
							["<C-d>"] = delete_buffer,
						},
						n = {
							["dd"] = delete_buffer,
						}
					}
				}
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[s]earch [h]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[s]earch [k]eymaps" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[s]earch [f]iles" })
		vim.keymap.set("n", "<leader>saf", function()
			builtin.find_files({hidden=true, no_ignore=true})
		end, { desc = "[s]earch [f]iles (hidden)" })
		vim.keymap.set("n", "<leader>sag", function()
			builtin.grep_string({
				additional_args = function()
					return {
						"--hidden", "--glob", "!.git/*",
					}
				end,
			})
		end, { desc = "[s]earch by [g]rep (hidden)" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[s]earch [s]elect telescope" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[s]earch current [w]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[s]earch by [g]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[s]earch [d]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[s]earch [r]esume" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[s]earch recent files ("." for repeat)' })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] find existing buffers" })
		vim.keymap.set('n', '<leader>/', function()
			-- you can pass additional configuration to telescope to change the theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
				winblend = 10,
			})
			end,
			{ desc = '[/] fuzzily search in current buffer' }
		)
		vim.keymap.set('n', '<leader>s/', function()
			builtin.live_grep {
				grep_open_files = true,
				prompt_title = 'Live Grep in Open Files',
			}
			end,
			{ desc = '[s]earch [/] in Open Files' }
		)
	end,
}

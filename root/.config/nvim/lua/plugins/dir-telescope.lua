return {
	'princejoogie/dir-telescope.nvim',
	dependencies = {'nvim-telescope/telescope.nvim'},
	cmd = { "Telescope" },
	config = function()
		require("dir-telescope").setup({
			hidden = true,
			no_ignore = true,
			show_preview = true,
			follow_symlink = false,
			live_grep = function(opts)
				require("telescope.builtin").live_grep(vim.tbl_extend("force", opts, {
					additional_args = { "--no-ignore", "--hidden" },
				}))
			end,
		})
	end,
	keys = {
		{ "<leader>gid", "<cmd>Telescope dir live_grep<CR>", noremap = true, silent = true },
		{ "<leader>fid", "<cmd>Telescope dir find_files<CR>", noremap = true, silent = true },
	},
}

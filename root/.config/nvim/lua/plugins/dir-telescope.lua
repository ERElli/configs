return {
	'princejoogie/dir-telescope.nvim',
	dependencies = {'nvim-telescope/telescope.nvim'},
	config = function()
		require("dir-telescope").setup({
			hidden = true,
			no_ignore = false,
			show_preview = true,
			follow_symlink = false,
		})
	end,
	keys = {
		{ "<leader>gid", "<cmd>Telescope dir live_grep<CR>", noremap = true, silent = true },
		{ "<leader>fid", "<cmd>Telescope dir find_files<CR>", noremap = true, silent = true },
	},
}

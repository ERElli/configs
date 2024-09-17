return {
	"tpope/vim-fugitive",
	event = 'BufWinEnter',
	dependencies = {
		"tpope/vim-rhubarb"
	},
	keys = {
		{
			"<leader>ghbf",
			":Git blame<cr>",
			desc = "Git Blame"
		}
	}
}

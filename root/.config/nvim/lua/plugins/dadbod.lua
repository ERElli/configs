return {
	'kristijanhusak/vim-dadbod-ui',
	dependencies = {
		{ 'tpope/vim-dadbod', lazy = true},
		{ 'kristijanhusak/vim-dadbod-completion', lazy = true},
	},
	cmd = {
		'DBUI',
		'DBUIToggle',
		'DBUIAddConnection',
		'DBUIFindBuffer',
	},
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1
	end,
	keys = {
		{
			'<leader>db',
			'<cmd>DBUI<cr><c-w>o',
			desc='Open dadbod UI'
		}
	}
}

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
		vim.g.db_ui_execute_on_save = 0
	end,
	keys = {
		{
			'<leader>dbt',
			'<cmd>tabnew<cr><cmd>DBUI<cr>',
			desc='Open [d]ad[b]od-ui in a new [t]ab'
		},
	}
}

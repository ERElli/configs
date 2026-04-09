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
		vim.env.PGCONNECT_TIMEOUT = "10"
	end,
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "dbui",
			callback = function()
				vim.api.nvim_buf_create_user_command(0, "DBUICollapseAll", function()
					vim.cmd([[
						let drawer = db_ui#drawer#get()
						for [key, db] in items(drawer.dbui.dbs)
							let db.expanded = 0
							let db.tables.expanded = 0
							if has_key(db, 'schemas')
								let db.schemas.expanded = 0
							endif
							let db.saved_queries.expanded = 0
							let db.buffers.expanded = 0
							for [tkey, table] in items(db.tables.items)
								let table.expanded = 0
							endfor
						endfor
						call drawer.render()
					]])
				end, {})
				vim.keymap.set("n", "<leader>dbca", "<cmd>DBUICollapseAll<cr>", { buffer = true, desc = "[d]ad[b]od [c]ollapse [a]ll" })
			end,
		})
	end,
	keys = {
		{
			'<leader>dbt',
			'<cmd>tabnew<cr><cmd>DBUI<cr>',
			desc = 'Open [d]ad[b]od-ui in a new [t]ab'
		},
	}
}

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'sql',
	desc = 'Detect sql files and set the commentstring',
	group = vim.api.nvim_create_augroup('sql-comment-string', {clear = true}),
	callback = function(ev)
		vim.bo[ev.buf].commentstring = '-- %s'
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'javascript',
	desc = 'Detect js files and set the commentstring',
	group = vim.api.nvim_create_augroup('js-comment-string', {clear = true}),
	callback = function(ev)
		vim.bo[ev.buf].commentstring = '// %s'
	end,
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
	pattern = '*.md',
	desc = 'Set conceal level to 2 for Obsidian markdown files',
	group = vim.api.nvim_create_augroup('obsidian-conceal-level', {clear = true}),
	callback = function()
		local filepath = vim.fn.expand("%:p")
		if filepath:match("^/Users/ericelli/Library/CloudStorage/ProtonDrive%-me@ericelli%.com%-folder/Obsidian_Vaults.*") then
			vim.opt_local.conceallevel = 2
		end
	end,
})

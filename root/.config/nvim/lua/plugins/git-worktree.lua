return {
	'polarmutex/git-worktree.nvim',
	version='^2',
	lazy = true,
	event = 'VeryLazy',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope.nvim'
	},
	config = function()
		local hooks = require('git-worktree.hooks')

		hooks.register(hooks.type.SWITCH, function(path, prev_path)
			local worktree_name = vim.fn.fnamemodify(path, ':t')
			local clean_name = worktree_name:gsub('[./]', '_')
			local session_name = vim.fn.system("tmux display-message -p '#S'"):gsub('\n', '')

			local result = vim.fn.system("tmux list-windows -t " .. vim.fn.shellescape(session_name) .. " -F '#{window_name}' 2>/dev/null")
			local window_exists = result:find(vim.pesc(clean_name))

			if window_exists then
				vim.fn.system('tmux select-window -t ' .. vim.fn.shellescape(clean_name))
				vim.notify('Switched to existing tmux window: ' .. worktree_name, vim.log.levels.INFO)
			else

				vim.fn.system('tmux-windowizer ' .. vim.fn.shellescape(path))
				vim.notify('Created new tmux window and switched to worktree: ' .. worktree_name, vim.log.levels.INFO)
			end
			if prev_path and vim.fn.isdirectory(prev_path) == 1 then
				vim.cmd('lcd ' .. vim.fn.fnameescape(prev_path))
			end
		end)

		hooks.register(hooks.type.DELETE, function(path)
			local window_name = vim.fn.fnamemodify(path, ':t')
			vim.fn.system('tmux kill-window -t ' .. vim.fn.shellescape(window_name))
			vim.notify('Deleted worktree: ' .. window_name, vim.log.levels.WARN)
		end)
	end,
	keys = {
		{
			'<leader>gwl',
			function()
				require('telescope').extensions.git_worktree.git_worktree()
			end,
			desc = '[g]it [w]orktrees [l]ist'
		},
		-- {
		-- This doesn't behave well with remote branches at the moment
		-- 	'<leader>gwc',
		-- 	function()
		-- 		require('telescope').extensions.git_worktree.create_git_worktree()
		-- 	end,
		-- 	desc = '[g]it [w]orktrees [c]reate'
		-- },
		{
			'<leader>gwd',
			function()
				require('telescope').extensions.git_worktree.git_worktree({
					attach_mappings = function(prompt_bufnr, map)
						local actions = require('telescope.actions')
						local action_state = require('telescope.actions.state')
						local git_worktree = require('git-worktree')

						map('i', '<C-d>', function()
							local selection = action_state.get_selected_entry()
							if selection then
								actions.close(prompt_bufnr)
								git_worktree.delete_worktree(selection.path, true) -- true for force delete
							end
						end)

						map('n', '<C-d>', function()
							local selection = action_state.get_selected_entry()
							if selection then
								actions.close(prompt_bufnr)
								git_worktree.delete_worktree(selection.path, true)
							end
						end)

						return true
					end,
				})
			end,
			desc = '[g]it [w]orktree [d]elete (Ctrl-d to delete)',
		}
	}
}

return {
	"utilyre/barbecue.nvim",
	event = "VeryLazy",
	dependencies = {
		"neovim/nvim-lspconfig",
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("barbecue").setup({})
		local barbecue_fugitive = vim.api.nvim_create_augroup('BarbecueFugitive', {clear=true})

		vim.api.nvim_create_autocmd('BufEnter', {
			group = barbecue_fugitive,
			callback = function()
				if vim.bo.filetype == 'fugitiveblame' then
					vim.defer_fn(function()
						require('barbecue.ui').toggle(false)
					end, 10)
				end
			end
		})

		vim.api.nvim_create_autocmd('BufLeave', {
			group = barbecue_fugitive,
			callback = function()
				if vim.bo.filetype == 'fugitiveblame' then
					vim.defer_fn(function()
						require('barbecue.ui').toggle(true)
						end, 10)
				end
			end
		})
	end,
}

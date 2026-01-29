return {
	'stevearc/conform.nvim',
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
		{
			"<leader>taf",
			function()
				vim.g.disable_autoformat = not vim.g.disable_autoformat
				if vim.g.disable_autoformat then
					print("Format on save disable")
				else
					print("Format on save enabled")
				end
			end,
			desc = "Toggle format on save",
		},
	},
	opts = {
		formatters_by_ft = {
			astro = { "prettier" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			json = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			markdown = { "prettier" },
			yaml = { "prettier" },
		},
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat then
				return
			end

			-- Disable format on save for specific filetypes or conditions
			-- if vim.bo[bufnr].filetype == "some_filetype" then
			--   return
			-- end


			return {
				timeout_ms = 500,
				lsp_fallback = true,
			}
		end,
	},
}

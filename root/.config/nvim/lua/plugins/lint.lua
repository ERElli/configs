return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" , "TextChanged" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n",
			"<leader>ll",
			function()
				lint.try_lint()
			end,
			{ desc ="[L]inting: Trigger [l]inting for current file" }
		)
		vim.keymap.set("n",
			"<leader>lef",
			'mF:%!eslint_d --stdin --fix-to-stdout<CR>`F',
			{desc = "[L]inting: [e]slint quick fix the whole [f]ile"}
		)
		vim.keymap.set("n",
			"<leader>lecl",
			'V:!eslint_d --stdin --fix-to-stdout<CR>',
			{desc = "[L]inting: [e]slint quick fix [c]urrent [l]ine"}
		)
	end,
}

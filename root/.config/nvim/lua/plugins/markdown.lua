return {
	{
		'MeanderingProgrammer/render-markdown.nvim',
		enabled=false,
		ft = 'markdown',
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
	{
		"iamcco/markdown-preview.nvim",
		event = "VeryLazy",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = "cd app && npm install",
		config = function()
			vim.api.nvim_create_user_command("MPObsidian", function()
				local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
				local content = table.concat(lines, "\n")
				-- Custom checkbox states → styled standard checkboxes
				content = content:gsub("([-*] )%[!%]", "%1[x] ⚠️")
				content = content:gsub("([-*] )%[%?%]", "%1[ ] ❓")
				-- [[Link|Display Text]] → [Display Text](Link.md)
				content = content:gsub("%[%[([^|%]]+)|([^%]]+)%]%]", "[%2](%1.md)")
				-- [[Link]] → [Link](Link.md)
				content = content:gsub("%[%[([^%]]+)%]%]", "[%1](%1.md)")
				local tmpfile = vim.fn.tempname() .. ".md"
				local f = io.open(tmpfile, "w")
				if f then
					f:write(content)
					f:close()
					vim.cmd("tabedit " .. tmpfile)
					vim.cmd("MarkdownPreview")
				end
			end, { desc = "MarkdownPreview with Obsidian wiki-links converted" })
		end,
	}
}

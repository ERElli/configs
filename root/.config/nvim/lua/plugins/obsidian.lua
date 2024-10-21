return {
	{
		"epwalsh/obsidian.nvim",
		version = "*",  -- recommended, use latest release instead of latest commit
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		-- 	-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		-- 	-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
		-- 	-- refer to `:h file-pattern` for more examples
		-- 	"BufReadPre " .. vim.fn.expand "~" .. "/Library/CloudStorage/ProtonDrive-me@ericelli.com-folder/Obsidian_Vaults/",
		-- 	"BufNewFile " .. vim.fn.expand "~" .. "/Library/CloudStorage/ProtonDrive-me@ericelli.com-folder/Obsidian_Vaults/",
		-- 	"BufNewFile " .. vim.fn.expand "~" .. "/Library/CloudStorage/ProtonDrive-me@ericelli.com-folder/Obsidian_Vaults/",
		-- 	-- "BufReadPre " .. vim.fn.expand "~" .. "/Library/CloudStorage/ProtonDrive-me@ericelli.com-folder/Obsidian_Vaults/Personal",
		-- 	-- "BufNewFile " .. vim.fn.expand "~" .. "/Library/CloudStorage/ProtonDrive-me@ericelli.com-folder/Obsidian_Vaults/Personal",
		-- },
		-- cond = vim.fn.getcwd() == vim.fn.expand("~/obsidian"),
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",
			-- Optional
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",

		},
		opts = {
			completion = {
				nvim_cmp = true,
				min_chars = 2,
			},
			mappings = {
				["gf"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end
				},
			},
			workspaces = {
				{
					name = "personal",
					path = "~/Library/CloudStorage/ProtonDrive-me@ericelli.com-folder/Obsidian_Vaults/Personal",
				}
			},
			templates = {
				subdir = "Templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
				substitutions = {
					noteId = function()
						return os.date("%Y%m%d%H%M")
					end
				}
			},
			ui = { enabled = false },
		},
		keys = {
			{
				"<leader>oo",
				"<cmd>cd" .. vim.fn.expand "~" .. "/Library/CloudStorage/ProtonDrive-me@ericelli.com-folder/Obsidian_Vaults<cr><cmd>pwd<cr>",
				desc="Navigate to Obsidian Vaults"
			},
			{
				"<leader>ot",
				"<cmd>ObsidianTemplate Note<cr>",
				desc="Add Note template to a note"
			},
			{
				"<leader>oft",
				"<cmd>s/# \\([^-_]\\+\\(-[^-_]\\+\\)*\\)_[0-9]\\+/# \\1/g | s/-/ /g<cr>",
				desc="Reformat obsidian note title"
			}
		},
	}
}


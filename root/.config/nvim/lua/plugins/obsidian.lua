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
			-- see below for full list of optional dependencies 👇
		},
		opts = {
			workspaces = {
				{
					name = "personal",
					path = "~/Library/CloudStorage/ProtonDrive-me@ericelli.com-folder/Obsidian_Vaults/Personal",
				}
				-- {
				-- 	name = "work",
				-- 	path = "~/Library/CloudStorage/ProtonDrive-me@ericelli.com-folder/Obsidian_Vaults/Work",
				-- },
			},
			templates = {
				subdir = "Templates",
				date_format = "%YYYY-%MM-%DD",
    			time_format = "%HH:%mm",
			}
		},
		keys = {
			{
				"<leader>oo",
				"<cmd>cd" .. vim.fn.expand "~" .. "/Library/CloudStorage/ProtonDrive-me@ericelli.com-folder/Obsidian_Vaults<cr><cmd>pwd<cr>",
				desc="Navigate to Obsidian Vaults"
			}
		},
		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},
	}
}


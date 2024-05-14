return {
	"ThePrimeagen/harpoon",
	lazy = false,
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({})

		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers").new({}, {
				prompt_title = "Harpoon",
				finder = require("telescope.finders").new_table({
					results = file_paths,
				}),
				previewer = conf.file_previewer({}),
				sorter = conf.generic_sorter({}),
			}):find()
		end
		vim.keymap.set("n", "<leader>ha", function() toggle_telescope(harpoon:list()) end, { desc = "List marked files" })
	end,
	keys = {
		{
			"<leader>hm",
			function()
				require("harpoon"):list():append()
			end,
			desc = "Mark file with harpoon",
		},
		{
			"<leader>hn",
			function()
				require("harpoon"):list():next()
			end,
			desc = "Go to next harpoon mark",
		},
		{
			"<leader>hp",
			function()
				require("harpoon"):list():prev()
			end,
			desc = "Go to previous harpoon mark",
		},
	},
}

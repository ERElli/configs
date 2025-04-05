return {
	"olimorris/codecompanion.nvim",
	lazy=false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		strategies = {
			chat = {
				adapter = "anthropic",
			},
			inline = {
				adapter = "anthropic",
			},
		},
		log_level = "DEBUG",
		adapters = {
			anthropic = function()
				return require("codecompanion.adapters").extend("anthropic", {
					env = {
						api_key = "cmd:op read op://personal/AnthropicKey/credential --no-newline",
					},
				})
			end,
		},
	},
}


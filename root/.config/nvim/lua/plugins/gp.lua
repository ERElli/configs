return {
	"robitx/gp.nvim",
	lazy=false,
	config = function()
		local conf = {
			openai_api_key = {
				"op",
				"read",
				"op://vault/item/field",
				"--account <account url here>",
			},
		}
		require("gp").setup(conf)
	end
}

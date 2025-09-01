return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"html",
					"javascript",
					"typescript",
					"tsx",
					"angular",
					"java",
					"rust",
                    "python",
					"json",
					"yaml",
					"terraform",
					"hcl",
					"dockerfile",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{ "dlvandenberg/tree-sitter-angular" },
}

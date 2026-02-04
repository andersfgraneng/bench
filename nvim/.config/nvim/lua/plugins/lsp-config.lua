return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- general programming languages/tools
					"jdtls", -- java
					"rust_analyzer", -- rust
					"lua_ls", -- lua
					"taplo", -- toml
					-- build/infrastructure tools
					"dockerls", -- docker
					"gh_actions_ls", -- github actions
					-- frontend tools/languages/frameworks
					"ts_ls", -- typescript
					"astro", -- astro
					"angularls", -- angular
					"tailwindcss", -- tailwind
					"html", -- html
				},
			})
		end,
	},
	"neovim/nvim-lspconfig",
}

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
					"jdtls",         -- java
					"rust_analyzer", -- rust
					"lua_ls",        -- lua
                    "pyright",       -- python
					"vacuum",        -- openapi 3
					"taplo",         -- toml
					-- build/infrastructure tools
					"terraformls",   -- terraform
					"tflint",        -- terraform
					"dockerls",      -- docker
					"gh_actions_ls", -- github actions
					-- frontend tools/languages/frameworks
					"ts_ls",         -- typescript
					"astro",         -- astro
					"angularls",     -- angular
					"tailwindcss",   -- tailwind
					"html",          -- html
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- general programming languages/tools
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})
			lspconfig.vacuum.setup({
				capabilities = capabilities,
			})
			lspconfig.taplo.setup({
				capabilities = capabilities,
			})

			-- build/infrastructure tools
			lspconfig.terraformls.setup({
				capabilities = capabilities,
				filetypes = {
					"tf",
					"terraform",
				},
			})
			lspconfig.tflint.setup({
				capabilities = capabilities,
				filetypes = {
					"tf",
					"terraform",
				},
			})
			lspconfig.dockerls.setup({
				capabilities = capabilities,
			})
			lspconfig.gh_actions_ls.setup({
				capabilities = capabilities,
			})

			-- frontend tools/languages/frameworks
			-- for ts remember you need to:
			-- npm install -g typescript typescript-language-server
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				filetypes = {
					"javascript",
					"typescript",
					"typescriptreact",
				},
			})
			lspconfig.astro.setup({
				capabilities = capabilities,
			})
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
				filetypes = {
					"html",
					"typescript",
					"astro",
				},
			})

			local util = require("lspconfig.util")
			lspconfig.angularls.setup({
				capabilities = capabilities,
				filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
				root_dir = util.root_pattern("angular.json", "project.json"),
			})

			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}

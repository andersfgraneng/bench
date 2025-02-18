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
					"jdtls",
					"rust_analyzer",
					"gopls",
					"lua_ls",
					"vacuum",
                    "taplo",
					-- build/infrastructure tools
					"terraformls",
          "tflint",
					"dockerls",
					-- frontend tools/languages/frameworks
					"ts_ls",
					"angularls",
          "volar",
					"tailwindcss",
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
			lspconfig.gopls.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
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
          "terraform"
        }
			})
			lspconfig.tflint.setup({
				capabilities = capabilities,
        filetypes = {
          "tf",
          "terraform"
        }
			})
			lspconfig.dockerls.setup({
				capabilities = capabilities,
			})

			-- frontend tools/languages/frameworks
			-- for ts remember you need to:
			-- npm install -g typescript typescript-language-server
			-- to support vue you also need:
			-- npm install -g @vue/typescript-plugin
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
              location = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
							languages = { "vue" },
						},
					},
				},
				filetypes = {
					"javascript",
					"typescript",
					"vue",
				},
			})
      lspconfig.volar.setup({
				capabilities = capabilities,
      })
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
			})
			local util = require("lspconfig.util")
			lspconfig.angularls.setup({
				capabilities = capabilities,
				filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
				root_dir = util.root_pattern("angular.json", "project.json"),
			})

			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
		end,
	},
}

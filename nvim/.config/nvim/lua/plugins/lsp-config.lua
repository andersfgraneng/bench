return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({ ensure_installed = { "java-debug-adapter", "java-test" } })
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
          -- build/infrastructure tools
          "terraformls",
          "dockerls",
          -- frontend tools/languages/frameworks
					"ts_ls",
					"angularls",
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
			lspconfig.jdtls.setup({
				capabilities = capabilities,
			})
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

      -- build/infrastructure tools
      lspconfig.terraformls.setup({
        capabilities = capabilities,
      })
      lspconfig.dockerls.setup({
        capabilities = capabilities,
      })

        -- frontend tools/languages/frameworks
			lspconfig.ts_ls.setup({
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

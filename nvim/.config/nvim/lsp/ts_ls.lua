local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- frontend tools/languages/frameworks
-- for ts remember you need to:
-- npm install -g typescript typescript-language-server
return {
	capabilities = capabilities,
	filetypes = {
		"javascript",
		"typescript",
		"typescriptreact",
	},
}

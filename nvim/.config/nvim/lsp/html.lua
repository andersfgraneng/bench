local capabilities = require("cmp_nvim_lsp").default_capabilities()
return {
	capabilities = capabilities,
	filetypes = {
		"html",
		"typescript",
		"astro",
	},
}

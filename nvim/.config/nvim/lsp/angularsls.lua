local capabilities = require("cmp_nvim_lsp").default_capabilities()
local util = require("lspconfig.util")
return {
	capabilities = capabilities,
	filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
	root_dir = util.root_pattern("angular.json", "project.json"),
}

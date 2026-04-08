local util = require("lspconfig.util")
return {
	filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
	root_dir = util.root_pattern("angular.json", "project.json"),
}

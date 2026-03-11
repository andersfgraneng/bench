return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			rust = { "clippy" },
			javascript = { "eslint" },
			typescript = { "eslint" },
			python = { "ruff", "pyrefly" },
			ghaction = { "actionlint" },
		}
	end,
}

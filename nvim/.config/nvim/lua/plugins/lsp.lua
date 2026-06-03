vim.pack.add({
	-- lsp --
	"https://github.com/neovim/nvim-lspconfig",
	-- mason
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	-- treesitter
	"https://github.com/nvim-treesitter/nvim-treesitter",
})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"rust_analyzer", -- rust
		"ts_ls", -- typescript
		"ty", -- python
		"lua_ls", -- lua
		"taplo", -- toml
		"dockerls", -- docker
		"gh_actions_ls", -- github actions
		"html", -- html
	},
})

-- for ts remember you need to:
-- npm install -g typescript typescript-language-server
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("ts_ls")
vim.lsp.enable("ty")
vim.lsp.enable("lua_ls")
vim.lsp.enable("taplo")
vim.lsp.enable("dockerls")
vim.lsp.enable("gh_actions_ls")
vim.lsp.enable("html")

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

local languages = {
	"rust",
	"lua",
	"python",
	"vim",
	"vimdoc",
	"html",
	"javascript",
	"typescript",
	"tsx",
	"json",
	"yaml",
	"dockerfile",
	"hurl",
	"markdown",
	"markdown_inline",
	"diff",
	"gitcommit",
}

require("nvim-treesitter").install(languages)

vim.api.nvim_create_autocmd("FileType", {
	pattern = languages,
	callback = function()
		vim.treesitter.start()
	end,
})

vim.filetype.add({
	filename = {
		[".env"] = "dotenv",
	},
	pattern = {
		["%.env%.[%w_.-]+"] = "dotenv",
		[".*/.github/workflows/.*%.yml"] = "yaml.ghaction",
	},
})

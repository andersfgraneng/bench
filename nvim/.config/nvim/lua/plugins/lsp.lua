vim.pack.add({
	-- lsp --
	"https://github.com/neovim/nvim-lspconfig",
	-- mason
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	-- treesitter
	"https://github.com/nvim-treesitter/nvim-treesitter",
})

local servers = {
	"rust_analyzer", -- rust
	"ts_ls", -- typescript
	"ty", -- python
	"lua_ls", -- lua
	"taplo", -- toml
	"dockerls", -- docker
	"gh_actions_ls", -- github actions
	"html", -- html
}

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

for _, server in ipairs(servers) do
	vim.lsp.enable(server)
end

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

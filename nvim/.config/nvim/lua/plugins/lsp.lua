local mise = require("util.mise")

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
	ensure_installed = mise.get_lsp_servers(),
})

for _, server in ipairs(mise.get_lsp_servers()) do
	vim.lsp.enable(server)
end

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

local languages = mise.get_treesitter_langs()
require("nvim-treesitter").install(languages)

vim.api.nvim_create_autocmd("FileType", {
	pattern = languages,
	callback = function()
		vim.treesitter.start()
	end,
})

vim.filetype.add({
	extension = {
		mdx = "mdx",
		conf = "conf",
	},
	filename = {
		[".env"] = "dotenv",
	},
	pattern = {
		["%.env%.[%w_.-]+"] = "dotenv",
		[".*/zfunctions/.*"] = "zsh",
		[".*/.github/workflows/.*%.yml"] = "yaml.ghaction",
	},
})

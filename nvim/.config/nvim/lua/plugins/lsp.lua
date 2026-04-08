vim.pack.add({
	-- lsp --
	"https://github.com/neovim/nvim-lspconfig",
	-- mason
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	-- treesitter
	"https://github.com/nvim-treesitter/nvim-treesitter",
	-- java
	"https://github.com/nvim-java/nvim-java",
})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		-- general programming languages/tools
		"jdtls", -- java
		"rust_analyzer", -- rust
		"lua_ls", -- lua
		"taplo", -- toml
		"pyrefly", -- python
		-- build/infrastructure tools
		"dockerls", -- docker
		"gh_actions_ls", -- github actions
		-- frontend tools/languages/frameworks
		"ts_ls", -- typescript
		"astro", -- astro
		"angularls", -- angular
		"tailwindcss", -- tailwind
		"html", -- html
	},
})

-- general programming languages/tools
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("lua_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("vacuum")
vim.lsp.enable("taplo")
vim.lsp.enable("jdtls")
-- build/infrastructure tools
vim.lsp.enable("terraformls")
vim.lsp.enable("tflint")
vim.lsp.enable("dockerls")
vim.lsp.enable("gh_actions_ls")
-- frontend tools/languages/frameworks
-- for ts remember you need to:
-- npm install -g typescript typescript-language-server
vim.lsp.enable("ts_ls")
vim.lsp.enable("astro")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("html")
vim.lsp.enable("angularls")

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

local languages = {
	"lua",
	"vim",
	"vimdoc",
	"html",
	"javascript",
	"typescript",
	"tsx",
	"angular",
	"java",
	"rust",
	"python",
	"json",
	"yaml",
	"terraform",
	"hcl",
	"dockerfile",
	"hurl",
	"markdown",
	"markdown_inline",
	"diff",
	"gitcommit",
	"http",
}

require("nvim-treesitter").install(languages)

vim.api.nvim_create_autocmd("FileType", {
	pattern = languages,
	callback = function()
		vim.treesitter.start()
	end,
})

vim.filetype.add({
	-- Detect by file extension (simple string match)
	extension = {
		mdx = "mdx",
		conf = "conf",
	},
	-- Detect by exact filename (simple string match)
	filename = {
		[".env"] = "dotenv",
	},
	-- Detect by Lua regex pattern (using '%' as an escape)
	pattern = {
		-- Matches filenames like ".env.example", ".env.local", etc.
		["%.env%.[%w_.-]+"] = "dotenv",
		-- Matches files in any 'zfunctions' directory as 'zsh' filetype
		[".*/zfunctions/.*"] = "zsh",
		[".*/.github/workflows/.*%.yml"] = "yaml.ghaction",
	},
})

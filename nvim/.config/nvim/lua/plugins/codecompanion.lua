vim.pack.add({
	"https://github.com/olimorris/codecompanion.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
})

require("codecompanion").setup({
  opts = {
    log_level = "DEBUG", -- or "TRACE"
  }
})

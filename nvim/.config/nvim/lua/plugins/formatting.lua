vim.pack.add({
	"https://github.com/stevearc/conform.nvim",
})

require("conform").setup({
	formatters_by_ft = require("util.mise").get_formatters(),
})

vim.keymap.set("n", "<leader>gf", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

vim.keymap.set("v", "<leader>gf", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format selection" })

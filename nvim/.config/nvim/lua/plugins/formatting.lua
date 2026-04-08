vim.pack.add({
	"https://github.com/stevearc/conform.nvim",
})

require("conform").setup({
	formatters_by_ft = {
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		python = { "ruff" },
		lua = { "stylua" },
		-- lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		-- You can customize some of the format options for the filetype (:help conform.format)
		-- Conform will run the first available formatter
	},
})
-- Keybinds
vim.keymap.set("n", "<leader>gf", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

vim.keymap.set("v", "<leader>gf", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format selection" })

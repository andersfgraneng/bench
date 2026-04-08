vim.pack.add({
	"https://github.com/f-person/git-blame.nvim",
	"https://github.com/sindrets/diffview.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/tpope/vim-fugitive",
})

vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})

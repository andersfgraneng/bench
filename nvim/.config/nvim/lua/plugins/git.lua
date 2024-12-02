return {
	{
    "f-person/git-blame.nvim"
  },
	{
		"sindrets/diffview.nvim",
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
			vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
		end,
	},
	{
		"tpope/vim-fugitive",
	},
}

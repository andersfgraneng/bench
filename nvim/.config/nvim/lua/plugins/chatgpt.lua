return {
	"jackMort/ChatGPT.nvim",
	event = "VeryLazy",
	config = function()
    local home = vim.fn.expand("$HOME")
		require("chatgpt").setup({
      api_key_cmd = home .. "/.config/getOAPIKEY.sh"
    })
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim", -- optional
		"nvim-telescope/telescope.nvim",
	},
}

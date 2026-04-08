vim.pack.add({
	-- ui --
	-- theme
	"https://github.com/rebelot/kanagawa.nvim",
	-- file explorer
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim", branch = "v3.x" },
	"https://github.com/nvim-lua/plenary.nvim",
	-- lualine
	"https://github.com/nvim-lualine/lualine.nvim",
	-- noice
	"https://github.com/folke/noice.nvim",
	-- telescope
	{
		src = "https://github.com/nvim-telescope/telescope.nvim",
		tag = "v0.2.1",
	},
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",

	-- dependecies --
	-- dependency for neo-tree and lualine
	"https://github.com/nvim-tree/nvim-web-devicons",
	-- dependency for neo-tree and noice
	"https://github.com/MunifTanjim/nui.nvim",
	-- dependency for noice
	-- OPTIONAL:
	--   `nvim-notify` is only needed, if you want to use the notification view.
	--   If not available, we use `mini` as the fallback
	"https://github.com/rcarriga/nvim-notify",
	-- dependency for telescope
	"https://github.com/nvim-lua/plenary.nvim",
})

require("plugins.ui")
require("plugins.telescope")

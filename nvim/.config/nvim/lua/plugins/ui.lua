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

	-- dependencies --
	-- dependency for neo-tree and lualine
	"https://github.com/nvim-tree/nvim-web-devicons",
	-- dependency for neo-tree and noice
	"https://github.com/MunifTanjim/nui.nvim",
	-- dependency for noice
	-- OPTIONAL:
	--   `nvim-notify` is only needed, if you want to use the notification view.
	--   If not available, we use `mini` as the fallback
	"https://github.com/rcarriga/nvim-notify",
})

-- colorscheme
require("kanagawa")
vim.cmd.colorscheme("kanagawa-wave")

-- file explorer
require("neo-tree").setup({
	filesystem = {
		filtered_items = {
			visible = true,
			show_hidden_count = true,
			hide_dotfiles = false,
			hide_gitignored = true,
		},
	},
})

vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>")
vim.keymap.set("n", "<C-m>", ":Neotree source=filesystem reveal=true position=float toggle=true<CR>")

-- lualine
require("lualine").setup({
	theme = "base16",
})

require("noice").setup({
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = true, -- add a border to hover docs and signature help
	},
	popupmenu = {
		enabled = true,
		backend = "cmp", -- use nui?
	},
})

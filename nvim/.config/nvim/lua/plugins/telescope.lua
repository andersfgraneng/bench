return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "v0.2.1",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

			vim.keymap.set("n", "<leader>gc", builtin.commands, { desc = "Telescope commands" })
			vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Telescope git status" })
			vim.keymap.set("n", "<leader>gl", builtin.git_commits, { desc = "Telescope git log" })
			vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Telescope git branches" })


			vim.keymap.set("n", "<leader>gr", builtin.lsp_references, { desc = "Telescope lsp list references" })
			vim.keymap.set("n", "<leader>gi", builtin.lsp_implementations, { desc = "Telescope Goto the implementation of the word under the cursor if there's only one, otherwise show all options in Telescope" })
			vim.keymap.set("n", "<leader>gd", builtin.lsp_definitions, { desc = "Telescope Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			local telescope = require("telescope")
			local telescopeConfig = require("telescope.config")

			-- Clone the default Telescope configuration
			local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

			-- I want to search in hidden/dot files.
			table.insert(vimgrep_arguments, "--hidden")
			-- I don't want to search in the `.git` directory.
			table.insert(vimgrep_arguments, "--glob")
			table.insert(vimgrep_arguments, "!**/.git/*")

			telescope.setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
				defaults = {
					-- `hidden = true` is not supported in text grep commands.
					vimgrep_arguments = vimgrep_arguments,
				},
				pickers = {
					find_files = {
						-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
					},
				},
			})

            telescope.load_extension("ui-select")
		end,
	},
}

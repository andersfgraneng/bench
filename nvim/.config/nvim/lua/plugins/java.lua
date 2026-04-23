vim.pack.add({
	"https://github.com/mfussenegger/nvim-jdtls",
})

local function make_jdtls_config()
	local mason_path = vim.fn.stdpath("data") .. "/mason"
	local workspace = vim.fn.stdpath("data")
		.. "/jdtls-workspace/"
		.. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

	local bundles = {}
	vim.list_extend(
		bundles,
		vim.split(
			vim.fn.glob(mason_path .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
			"\n",
			{ trimempty = true }
		)
	)
	vim.list_extend(
		bundles,
		vim.split(
			vim.fn.glob(mason_path .. "/packages/java-test/extension/server/*.jar"),
			"\n",
			{ trimempty = true }
		)
	)

	return {
		cmd = { mason_path .. "/bin/jdtls", "-data", workspace },
		root_dir = vim.fs.dirname(
			vim.fs.find({ "gradlew", "mvnw", "pom.xml", "build.gradle", ".git" }, { upward = true })[1]
		) or vim.fn.getcwd(),
		settings = {
			java = {
				eclipse = { downloadSources = true },
				maven = { downloadSources = true },
				configuration = { updateBuildConfiguration = "interactive" },
				implementationsCodeLens = { enabled = true },
				referencesCodeLens = { enabled = true },
			},
		},
		init_options = { bundles = bundles },
		on_attach = function()
			require("jdtls").setup_dap({ hotcodereplace = "auto" })
		end,
	}
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		require("jdtls").start_or_attach(make_jdtls_config())
	end,
})

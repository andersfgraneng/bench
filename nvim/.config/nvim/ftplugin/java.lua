local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
	return
end

local mason_path = vim.fn.stdpath("data") .. "/mason"
local mason_jdtls = mason_path .. "/bin/jdtls"
local cmd = vim.fn.executable(mason_jdtls) == 1 and { mason_jdtls } or { "jdtls" }

local bundles = {}
vim.list_extend(
	bundles,
	vim.split(vim.fn.glob(mason_path .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true), "\n", { trimempty = true })
)
local excluded_test_jars = {
	["com.microsoft.java.test.runner-jar-with-dependencies.jar"] = true,
	["jacocoagent.jar"] = true,
}
for _, jar in ipairs(vim.split(vim.fn.glob(mason_path .. "/packages/java-test/extension/server/*.jar", true), "\n", { trimempty = true })) do
	if not excluded_test_jars[vim.fn.fnamemodify(jar, ":t")] then
		table.insert(bundles, jar)
	end
end

jdtls.start_or_attach({
	name = "jdtls",
	cmd = cmd,
	root_dir = vim.fs.root(0, { "gradlew", "mvnw", "pom.xml", "build.gradle", "build.gradle.kts", ".git" }),
	settings = {
		java = {},
	},
	init_options = {
		bundles = bundles,
	},
	on_attach = function()
		if #bundles > 0 then
			jdtls.setup_dap({ hotcodereplace = "auto" })
		end
	end,
})

local opts = { buffer = 0, silent = true }
vim.keymap.set("n", "<leader>tc", jdtls.test_class, vim.tbl_extend("force", opts, { desc = "Java: test class" }))
vim.keymap.set("n", "<leader>tm", jdtls.test_nearest_method, vim.tbl_extend("force", opts, { desc = "Java: test nearest method" }))

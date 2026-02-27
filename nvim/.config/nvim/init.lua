require("vim-config")
require("config.lazy")

-- general programming languages/tools
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("lua_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("vacuum")
vim.lsp.enable("taplo")
-- build/infrastructure tools
vim.lsp.enable("terraformls")
vim.lsp.enable("tflint")
vim.lsp.enable("dockerls")
vim.lsp.enable("gh_actions_ls")
-- frontend tools/languages/frameworks
-- for ts remember you need to:
-- npm install -g typescript typescript-language-server
vim.lsp.enable("ts_ls")
vim.lsp.enable("astro")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("html")
vim.lsp.enable("angularls")

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "lua",
        "vim",
        "vimdoc",
        "html",
        "javascript",
        "typescript",
        "tsx",
        "angular",
        "java",
        "rust",
        "python",
        "json",
        "yaml",
        "terraform",
        "hcl",
        "dockerfile",
        "hurl",
        "markdown",
        "markdown_inline",
        "diff",
        "gitcommit",
    },
    callback = function()
        vim.treesitter.start()
    end,
})

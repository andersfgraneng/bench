return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        init = function()
            require("nvim-treesitter").install({
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
                "gitcommit"
            })
        end,
    },
    { "dlvandenberg/tree-sitter-angular" },
}

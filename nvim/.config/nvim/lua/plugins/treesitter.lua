return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "javascript",
          "typescript",
          "html",
          "java",
          "rust",
          "angular",
          "json",
          "yaml",
          "terraform",
          "hcl",
          "go",
          "dockerfile"
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  { "dlvandenberg/tree-sitter-angular" },
}

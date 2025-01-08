return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "javascript",
          "typescript",
          "html",
          "java",
          "kotlin",
          "rust",
          "angular",
          "json",
          "yaml",
          "terraform",
          "hcl"
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  { "dlvandenberg/tree-sitter-angular" },
}

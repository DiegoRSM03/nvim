-- ============================================================
-- NVIM-TREESITTER (new API, v1.0+)
-- nvim-treesitter.configs was removed in recent versions.
-- Configuration is now done directly on the nvim-treesitter module.
-- ============================================================
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "javascript", "typescript", "tsx",
          "html", "css", "json", "yaml",
          "lua", "vim", "vimdoc",
          "bash", "markdown", "markdown_inline",
        },
        auto_install = true,
        highlight = { enable = true },
        indent    = { enable = true },
      })
    end,
  },

  -- Text objects: select/move by function, class, parameter
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start     = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
        },
      })
    end,
  },
}

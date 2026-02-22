-- ============================================================
-- CATPPUCCIN COLORSCHEME
-- ============================================================
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- load before all other plugins
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",         -- mocha = darkest. Options: latte, frappe, macchiato, mocha
      transparent_background = false,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = false,
        oil = true,
        treesitter = true,
        mason = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}

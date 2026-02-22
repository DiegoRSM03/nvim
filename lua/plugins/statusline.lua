-- ============================================================
-- LUALINE
-- Minimal statusline: mode + filename only, catppuccin themed
-- ============================================================
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        theme = "catppuccin",
        component_separators = "",    -- no separators for a clean look
        section_separators = "",
        globalstatus = true,          -- single statusline across all splits
      },
      sections = {
        -- Left: mode indicator
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = {
          {
            "filename",
            path = 1,  -- show relative path (0 = just name, 2 = absolute)
            symbols = {
              modified = "●",
              readonly = "",
              unnamed  = "[No Name]",
            },
          },
        },
        -- Right: nothing (keeping it truly minimal)
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_c = { "filename" },
        lualine_x = {},
      },
    })
  end,
}

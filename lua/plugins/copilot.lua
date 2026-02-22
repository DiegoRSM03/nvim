-- ============================================================
-- GITHUB COPILOT
-- AI completion integrated into nvim-cmp via copilot-cmp
-- Run :Copilot auth the first time to authenticate
-- ============================================================
return {
  -- Core copilot engine
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        -- Disable copilot's built-in suggestion UI since we use copilot-cmp
        suggestion = { enabled = false },
        panel      = { enabled = false },
        filetypes  = {
          yaml       = true,
          markdown   = true,
          gitcommit  = true,
          ["*"]      = true,   -- enable for all filetypes
        },
      })
    end,
  },

  -- Copilot as a cmp source (shows in completion menu)
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}

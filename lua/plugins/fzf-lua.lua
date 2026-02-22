-- ============================================================
-- FZF-LUA
-- Fast fuzzy finder backed by the fzf binary
-- Requires: fzf, ripgrep (brew install fzf ripgrep)
-- ============================================================
return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")

    fzf.setup({
      winopts = {
        height = 0.85,
        width = 0.80,
        preview = {
          layout = "vertical",
          vertical = "down:50%",
        },
      },
      -- Use ripgrep for file search (respects .gitignore)
      files = {
        cmd = "rg --files --hidden --follow --glob '!.git/*'",
      },
    })
  end,
}

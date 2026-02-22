-- ============================================================
-- OIL.NVIM
-- Edit your filesystem like a buffer.
-- Navigate: open oil, move around, edit names, :w to apply.
-- ============================================================
return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- Load immediately so it can handle `nvim .` from terminal
  lazy = false,
  config = function()
    require("oil").setup({
      -- Show oil buffer as a floating window
      default_file_explorer = true,
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
      view_options = {
        show_hidden = true, -- show dotfiles
      },
      -- Keymaps inside oil buffer
      keymaps = {
        ["g?"]  = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-x>"] = "actions.select_split",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["-"]    = "actions.parent",   -- go up a directory
        ["_"]    = "actions.open_cwd",
        ["`"]    = "actions.cd",
        ["gs"]   = "actions.change_sort",
        ["gx"]   = "actions.open_external",
        ["g."]   = "actions.toggle_hidden",
      },
      use_default_keymaps = false, -- only use the ones above
    })
  end,
}

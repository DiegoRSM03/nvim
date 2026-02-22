-- ============================================================
-- MISC PLUGINS
-- autopairs, surround, gitsigns
-- ============================================================
return {
  -- ── Auto pairs ────────────────────────────────────────────────
  -- Automatically closes brackets, quotes, etc.
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")
      autopairs.setup({ check_ts = true }) -- treesitter-aware pairing

      -- Integrate with nvim-cmp: auto add closing pair on confirm
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- ── nvim-surround ─────────────────────────────────────────────
  -- Add/change/delete surrounding pairs
  -- ys{motion}{char}  → add surrounding    e.g. ysiw" wraps word in quotes
  -- cs{old}{new}      → change surrounding e.g. cs"' changes " to '
  -- ds{char}          → delete surrounding e.g. ds" removes surrounding "
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    version = "*",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- ── Gitsigns ──────────────────────────────────────────────────
  -- Git hunk indicators in the sign column + inline blame
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = "▎" },
          change       = { text = "▎" },
          delete       = { text = "" },
          topdelete    = { text = "" },
          changedelete = { text = "▎" },
        },
        current_line_blame = false, -- toggle with <leader>gb
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local map = function(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
          end

          -- Navigation between hunks
          map("n", "]h", gs.next_hunk,  "Next hunk")
          map("n", "[h", gs.prev_hunk,  "Prev hunk")

          -- Actions
          map("n", "<leader>gs", gs.stage_hunk,   "Stage hunk")
          map("n", "<leader>gr", gs.reset_hunk,   "Reset hunk")
          map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
          map("n", "<leader>gb", gs.toggle_current_line_blame, "Toggle line blame")
          map("n", "<leader>gd", gs.diffthis,     "Diff this")
        end,
      })
    end,
  },

  -- ── nvim-web-devicons ─────────────────────────────────────────
  -- File icons used by oil, fzf-lua, lualine
  -- Requires a Nerd Font: https://www.nerdfonts.com
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
}

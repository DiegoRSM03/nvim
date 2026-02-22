-- ============================================================
-- KEYMAPS
-- ============================================================
local map = vim.keymap.set

-- Exit insert mode with "jk"
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- ── Window navigation ────────────────────────────────────────
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })

-- ── Buffer navigation ────────────────────────────────────────
map("n", "<Tab>",   ":bnext<CR>",     { desc = "Next buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>q", function()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  if #bufs <= 1 then
    -- Last buffer: create empty buffer, then delete old one
    local current = vim.api.nvim_get_current_buf()
    vim.cmd("enew")
    vim.api.nvim_buf_delete(current, { force = false })
  else
    -- Switch to next buffer, then delete the previous one
    local current = vim.api.nvim_get_current_buf()
    vim.cmd("bnext")
    vim.api.nvim_buf_delete(current, { force = false })
  end
end, { desc = "Close current buffer" })
map("n", "<leader>Q", "<cmd>qa<CR>",      { desc = "Quit all" })

-- ── Save ─────────────────────────────────────────────────────
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })

-- ── fzf-lua ──────────────────────────────────────────────────
map("n", "<leader>ff", "<cmd>FzfLua files<CR>",       { desc = "Find files" })
map("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>",   { desc = "Live grep (codebase)" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>",     { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>",   { desc = "Help tags" })
map("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>",    { desc = "Recent files" })
map("n", "<leader>fc", "<cmd>FzfLua commands<CR>",    { desc = "Commands" })
map("n", "<leader>fs", "<cmd>FzfLua grep_curbuf<CR>", { desc = "Search current file" })

-- ── LSP ──────────────────────────────────────────────────────
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
map("n", "[d", vim.diagnostic.goto_prev,         { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next,         { desc = "Next diagnostic" })

-- ── Neo-tree ─────────────────────────────────────────────────
map("n", "<leader>e", function()
  if vim.bo.filetype == "neo-tree" then
    vim.cmd.wincmd("p") -- jump to previous window
  else
    vim.cmd("Neotree focus")
  end
end, { desc = "Toggle focus: neo-tree ↔ code" })

-- ── Misc ─────────────────────────────────────────────────────
-- Move selected lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Keep cursor in place when joining lines
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })

-- Keep search results centered
map("n", "n", "nzzzv", { desc = "Next result (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev result (centered)" })

-- Clear search highlight
map("n", "<leader>nh", "<cmd>noh<CR>", { desc = "Clear search highlight" })

-- ── Smart quit ─────────────────────────────────────────────────
-- If only an empty [No Name] buffer remains, quit nvim entirely
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local bufs = vim.fn.getbufinfo({ buflisted = 1 })
    if #bufs == 1 then
      local buf = bufs[1]
      -- Empty unnamed buffer with no changes
      if buf.name == "" and buf.changed == 0 and vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
        vim.cmd("qa!")
      end
    end
  end,
})

-- ============================================================
-- OPTIONS
-- ============================================================
local opt = vim.opt

-- Leader key (must be set before plugins load)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Clipboard: sync with macOS system clipboard
-- Yanking in nvim = available via Cmd+V anywhere on Mac
opt.clipboard = "unnamedplus"

-- Line numbers
opt.number = true
opt.relativenumber = true -- relative numbers for easy jump motions (12j, 5k, etc.)

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true -- spaces instead of tabs
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true -- case-sensitive only when you type uppercase
opt.hlsearch = false -- don't keep matches highlighted after search

-- Appearance
opt.termguicolors = true -- full color support (required for catppuccin)
opt.signcolumn = "yes" -- always show sign column (prevents layout shifts from LSP)
opt.cursorline = true -- highlight current line
opt.scrolloff = 8 -- keep 8 lines above/below cursor when scrolling
opt.sidescrolloff = 8

-- Splits
opt.splitbelow = true -- horizontal splits go below
opt.splitright = true -- vertical splits go right

-- Performance
opt.updatetime = 100 -- faster CursorHold events (used by LSP, gitsigns)
opt.timeoutlen = 300 -- how long to wait for mapped key sequences (ms)

-- Files
opt.swapfile = false
opt.backup = false
opt.undofile = true -- persistent undo history across sessions

-- Wrap
opt.wrap = false -- no line wrapping

-- Feel
opt.mouse = "a" -- enable mouse support

-- Project-local config: source .nvim.lua from cwd (with trust prompt)
opt.exrc = true

-- Disable italics globally, regardless of colorscheme.
-- Strips the italic attribute from every highlight group; re-runs on
-- each :colorscheme change (incl. the :FzfLua colorschemes picker).
-- Runs twice: a scheduled pass (after synchronous handlers like neo-tree)
-- and a short deferred pass (catches themes that apply highlights via an
-- async handle a tick later, e.g. material.nvim).
local function strip_italics()
  for name, hl in pairs(vim.api.nvim_get_hl(0, {})) do
    local changed = false
    if hl.italic then
      hl.italic = false
      changed = true
    end
    if hl.cterm and hl.cterm.italic then
      hl.cterm.italic = nil
      changed = true
    end
    if changed then
      vim.api.nvim_set_hl(0, name, hl)
    end
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("NoItalics", { clear = true }),
  callback = function()
    vim.schedule(strip_italics)
    vim.defer_fn(strip_italics, 50)
  end,
})

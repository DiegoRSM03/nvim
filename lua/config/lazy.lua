-- ============================================================
-- LAZY.NVIM BOOTSTRAP
-- Automatically installs lazy.nvim if not present
-- ============================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- ============================================================
-- LOAD ALL PLUGINS
-- Each file in lua/plugins/ returns a plugin spec table
-- ============================================================
require("lazy").setup("plugins", {
  change_detection = {
    notify = false, -- don't notify when config files change
  },
  performance = {
    rtp = {
      -- Disable unused built-in plugins for faster startup
      disabled_plugins = {
        "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin",
      },
    },
  },
})

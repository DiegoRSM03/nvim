# CLAUDE.md — Neovim Config Repository

This file gives Claude Code the context it needs to work on this repository
effectively. Read this before making any changes.

---

## What This Repo Is

Personal Neovim configuration for macOS. Written entirely in Lua targeting
Neovim 0.11+. The goal is a minimalistic but powerful setup for web development
(JS/TS/TSX/HTML/CSS/JSON/YAML) with a clean aesthetic and no unnecessary bloat.

---

## Core Principles

- **Minimalism first.** Don't add a plugin unless it solves a real problem.
- **Performance matters.** Prefer plugins that are fast and don't block the editor.
- **No Vimscript.** Everything is Lua.
- **No single giant config file.** Each plugin gets its own file under `lua/plugins/`.
- **Prefer newer APIs.** We're on Neovim 0.11+ — use native APIs where available
  (e.g. `vim.lsp.config` instead of the deprecated lspconfig setup pattern).

---

## File Structure

```
~/.config/nvim/
├── init.lua                  # entry point — loads config.options, keymaps, lazy
└── lua/
    ├── config/
    │   ├── options.lua       # vim options (leader, clipboard, indentation, etc.)
    │   ├── keymaps.lua       # all keybindings in one place
    │   └── lazy.lua          # lazy.nvim bootstrap and plugin loader
    └── plugins/              # one file per plugin
```

When adding a new plugin, always create a new file in `lua/plugins/`.
Never add plugin specs directly to `lazy.lua` or `init.lua`.

---

## Key User Preferences

- **Leader key:** `,`
- **Exit insert mode:** `jk`
- **Clipboard:** macOS system clipboard (`unnamedplus`) — yank in nvim, paste with Cmd+V
- **Indentation:** 2 spaces, expandtab
- **No mouse** usage in the editor — all interactions must be keyboard-driven
- **No line wrapping**
- **Relative line numbers**

---

## Current Plugin Stack

| Plugin | Purpose |
|--------|---------|
| lazy.nvim | Plugin manager |
| catppuccin (mocha) | Colorscheme |
| bufferline.nvim | Buffer bar at the top |
| fzf-lua | Fuzzy finder (files, grep, buffers) |
| nvim-treesitter | Syntax highlighting + text objects |
| mason.nvim + mason-lspconfig | LSP server installer |
| nvim-lspconfig | LSP server definitions |
| conform.nvim | Async formatting on save |
| nvim-lint | Linting (eslint_d) |
| nvim-cmp + sources | Autocompletion |
| LuaSnip + friendly-snippets | Snippets |
| neo-tree.nvim | Persistent file explorer sidebar |
| lualine.nvim | Minimal statusline |
| copilot.lua + copilot-cmp | GitHub Copilot via cmp |
| nvim-autopairs | Auto-close brackets/quotes |
| nvim-surround | ys/cs/ds surround motions |
| gitsigns.nvim | Git hunk indicators + inline blame |
| nvim-web-devicons | File icons |

---

## Important Technical Decisions

**LSP uses Neovim 0.11 native API.**
Use `vim.lsp.config("server", opts)` and `vim.lsp.enable("server")`.
Do NOT use the old `require("lspconfig").server.setup()` pattern — it is
deprecated and will be removed in nvim-lspconfig v3.0.0.

**Treesitter uses the new v1.0+ API.**
Use `require("nvim-treesitter").setup({})`.
Do NOT use `require("nvim-treesitter.configs").setup({})` — that module was
removed in recent versions and will throw a module-not-found error.

**Treesitter must not be lazy-loaded.**
Set `lazy = false` on the nvim-treesitter spec to avoid race conditions where
other plugins trigger filetype events before treesitter is ready.

**oil.nvim is not in this config.**
It was evaluated and replaced by neo-tree. Do not add it back.

---

## Language Support

The following languages have full LSP + formatting + linting support:

| Language | LSP Server | Formatter | Linter |
|----------|-----------|-----------|--------|
| JavaScript | ts_ls | prettier | eslint_d |
| TypeScript | ts_ls | prettier | eslint_d |
| TSX | ts_ls | prettier | eslint_d |
| HTML | html | prettier | — |
| CSS | cssls | prettier | — |
| JSON | jsonls | prettier | — |
| YAML | yamlls | prettier | — |
| Lua | lua_ls | stylua | — |

---

## System Dependencies

```bash
brew install neovim fzf ripgrep stylua
brew install --cask font-jetbrains-mono-nerd-font
npm install -g prettier eslint_d
```

---

## Keymaps Cheatsheet

### Navigation
| Key | Action |
|-----|--------|
| `Tab` / `Shift+Tab` | Next / previous buffer |
| `,e` | Toggle focus: neo-tree ↔ code |
| `Ctrl+h/j/k/l` | Move between splits |
| `Ctrl+o` / `Ctrl+i` | Jump back / forward (across files) |

### Files & Search
| Key | Action |
|-----|--------|
| `,ff` | Find file by name |
| `,fg` | Live grep across codebase |
| `,fs` | Search in current file |
| `,fb` | Switch open buffers |
| `,fr` | Recent files |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | References |
| `K` | Hover docs |
| `,rn` | Rename symbol |
| `,ca` | Code action |
| `,fm` | Format file |

### Editing
| Key | Action |
|-----|--------|
| `jk` | Exit insert mode |
| `,w` | Save |
| `,q` | Close buffer |
| `,Q` | Quit all |
| `ys{motion}{char}` | Add surrounding |
| `cs{old}{new}` | Change surrounding |
| `ds{char}` | Delete surrounding |

### Git
| Key | Action |
|-----|--------|
| `]h` / `[h` | Next / previous hunk |
| `,gs` | Stage hunk |
| `,gb` | Toggle inline blame |
| `,gd` | Diff this |

---

## How to Add a New Plugin

1. Create `lua/plugins/pluginname.lua`
2. Return a valid lazy.nvim plugin spec table
3. Follow the existing patterns in other plugin files
4. Add any new keymaps to `lua/config/keymaps.lua` with a `desc` field
5. Update this CLAUDE.md if the plugin is significant

## How to Add a New Language

1. Add the LSP server name to `ensure_installed` in `lsp.lua`
2. Add a `vim.lsp.config("server", { capabilities = capabilities })` call
3. Add the formatter to `formatters_by_ft` in the conform block in `lsp.lua`
4. Add the linter to `linters_by_ft` in `misc.lua` if applicable
5. Add the treesitter parser to `ensure_installed` in `treesitter.lua`
6. Update the language support table in this file

---

## README

The README.md should always reflect the current state of this file.
When making changes that affect setup, keymaps or plugin choices,
update README.md accordingly.

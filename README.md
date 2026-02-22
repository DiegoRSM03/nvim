# Neovim Config

Minimalistic Neovim configuration for macOS, written entirely in Lua. Targets Neovim 0.11+ and focuses on web development (JS/TS/TSX/HTML/CSS/JSON/YAML) with a clean aesthetic.

## Features

- **Pure Lua** — No Vimscript, leverages Neovim 0.11+ native APIs
- **Fast startup** — Lazy-loaded plugins via lazy.nvim
- **Persistent sidebar** — Neo-tree file explorer always visible
- **Smart buffer management** — Closing last buffer keeps editor usable
- **Full LSP support** — Autocompletion, diagnostics, formatting, linting
- **GitHub Copilot** — AI-powered code suggestions
- **Fuzzy finding** — Files, grep, buffers via fzf-lua
- **Git integration** — Gitsigns for hunks, blame, and diffs

## Requirements

```bash
# Core
brew install neovim fzf ripgrep

# Fonts (required for icons)
brew install --cask font-jetbrains-mono-nerd-font

# Formatters & Linters
brew install stylua
npm install -g prettier eslint_d
```

## Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this repo
git clone https://github.com/YOUR_USERNAME/nvim-config.git ~/.config/nvim

# Start Neovim (plugins install automatically)
nvim
```

## File Structure

```
~/.config/nvim/
├── init.lua                  # Entry point
├── lazy-lock.json            # Plugin version lock
└── lua/
    ├── config/
    │   ├── options.lua       # Vim options
    │   ├── keymaps.lua       # All keybindings
    │   └── lazy.lua          # Plugin manager bootstrap
    └── plugins/              # One file per plugin
        ├── bufferline.lua
        ├── catppuccin.lua
        ├── completion.lua
        ├── copilot.lua
        ├── fzf-lua.lua
        ├── lsp.lua
        ├── misc.lua
        ├── neo-tree.lua
        ├── statusline.lua
        └── treesitter.lua
```

## Plugins

| Plugin | Purpose |
|--------|---------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [catppuccin](https://github.com/catppuccin/nvim) | Colorscheme (mocha) |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Buffer tabs |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer sidebar |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [fzf-lua](https://github.com/ibhagwan/fzf-lua) | Fuzzy finder |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP/formatter installer |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configurations |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Async formatting |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Linting |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippets |
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | GitHub Copilot |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git integration |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-close brackets |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Surround motions |

## Keymaps

**Leader key:** `,`

### General

| Key | Action |
|-----|--------|
| `jk` | Exit insert mode |
| `,w` | Save file |
| `,q` | Close buffer (switches to next) |
| `,Q` | Quit all |
| `:q` | Quit (closes nvim if only empty buffer remains) |

### Navigation

| Key | Action |
|-----|--------|
| `Tab` / `Shift+Tab` | Next / previous buffer |
| `,e` | Toggle focus: neo-tree ↔ code |
| `Ctrl+h/j/k/l` | Move between splits |

### File Explorer (Neo-tree)

| Key | Action |
|-----|--------|
| `Enter` / `o` | Open file |
| `r` | Rename |
| `a` | Add file/directory |
| `d` | Delete |
| `H` | Toggle hidden files |
| `-` | Navigate up |
| `?` | Show help |

### Fuzzy Finder

| Key | Action |
|-----|--------|
| `,ff` | Find files |
| `,fg` | Live grep |
| `,fb` | Find buffers |
| `,fr` | Recent files |
| `,fs` | Search current file |
| `,fh` | Help tags |
| `,fc` | Commands |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | References |
| `gi` | Go to implementation |
| `K` | Hover docs |
| `,rn` | Rename symbol |
| `,ca` | Code action |
| `,D` | Type definition |
| `,d` | Show diagnostic |
| `[d` / `]d` | Previous / next diagnostic |
| `,fm` | Format file |

### Git

| Key | Action |
|-----|--------|
| `]h` / `[h` | Next / previous hunk |
| `,gs` | Stage hunk |
| `,gr` | Reset hunk |
| `,gp` | Preview hunk |
| `,gb` | Toggle line blame |
| `,gd` | Diff this |

### Surround

| Key | Action |
|-----|--------|
| `ys{motion}{char}` | Add surrounding (e.g., `ysiw"` wraps word in quotes) |
| `cs{old}{new}` | Change surrounding (e.g., `cs"'` changes `"` to `'`) |
| `ds{char}` | Delete surrounding (e.g., `ds"` removes quotes) |

### Misc

| Key | Action |
|-----|--------|
| `J` / `K` (visual) | Move selection down / up |
| `n` / `N` | Next / prev search result (centered) |
| `,nh` | Clear search highlight |

## Language Support

| Language | LSP | Formatter | Linter |
|----------|-----|-----------|--------|
| JavaScript | ts_ls | prettier | eslint_d |
| TypeScript | ts_ls | prettier | eslint_d |
| TSX/JSX | ts_ls | prettier | eslint_d |
| HTML | html | prettier | — |
| CSS | cssls | prettier | — |
| JSON | jsonls | prettier | — |
| YAML | yamlls | prettier | — |
| Lua | lua_ls | stylua | — |

## License

MIT

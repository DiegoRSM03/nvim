-- ============================================================
-- LSP SETUP (Neovim 0.11+ native API)
-- mason: auto-installs language servers
-- mason-lspconfig: bridges mason with vim.lsp.config
-- conform: async formatting
-- nvim-lint: linting
-- ============================================================
return {
  -- Mason: LSP/formatter/linter installer UI
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = { border = "rounded" },
      })
    end,
  },

  -- mason-lspconfig: auto-installs servers and hooks into vim.lsp.enable()
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",  -- still needed for server definitions/defaults
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- ── LSP keymaps (fires when any LSP attaches to a buffer) ──
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local map = vim.keymap.set
          local opts = { buffer = ev.buf }

          map("n", "gd",         vim.lsp.buf.definition,      vim.tbl_extend("force", opts, { desc = "Go to definition" }))
          map("n", "gD",         vim.lsp.buf.declaration,     vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
          map("n", "gr",         vim.lsp.buf.references,      vim.tbl_extend("force", opts, { desc = "References" }))
          map("n", "gi",         vim.lsp.buf.implementation,  vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
          map("n", "K",          vim.lsp.buf.hover,           vim.tbl_extend("force", opts, { desc = "Hover docs" }))
          map("n", "<leader>rn", vim.lsp.buf.rename,          vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
          map("n", "<leader>ca", vim.lsp.buf.code_action,     vim.tbl_extend("force", opts, { desc = "Code action" }))
          map("n", "<leader>D",  vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Type definition" }))
        end,
      })

      -- ── Server configs via new vim.lsp.config API ──────────────
      -- Simple servers with no extra settings
      for _, server in ipairs({ "html", "cssls", "jsonls", "yamlls", "eslint" }) do
        vim.lsp.config(server, { capabilities = capabilities })
      end

      -- TypeScript / JavaScript
      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        settings = {
          typescript = { inlayHints = { includeInlayParameterNameHints = "all" } },
          javascript = { inlayHints = { includeInlayParameterNameHints = "all" } },
        },
      })

      -- Lua (Neovim-aware: understands 'vim' global, runtime files)
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- ── Auto-install all servers via mason ─────────────────────
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",   -- TypeScript / JavaScript
          "html",    -- HTML
          "cssls",   -- CSS
          "jsonls",  -- JSON
          "yamlls",  -- YAML
          "lua_ls",  -- Lua
          "eslint",  -- ESLint
        },
        automatic_installation = true,
        -- Enable each server after mason installs it
        handlers = {
          function(server_name)
            vim.lsp.enable(server_name)
          end,
        },
      })
    end,
  },

  -- ── conform.nvim: async formatting ────────────────────────────
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup({
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        formatters_by_ft = {
          javascript      = { "prettier" },
          javascriptreact = { "prettier" },
          typescript      = { "prettier" },
          typescriptreact = { "prettier" },
          html            = { "prettier" },
          css             = { "prettier" },
          json            = { "prettier" },
          yaml            = { "prettier" },
          lua             = { "stylua" },
        },
      })
      vim.keymap.set({ "n", "v" }, "<leader>fm", function()
        require("conform").format({ async = true, lsp_fallback = true })
      end, { desc = "Format file" })
    end,
  },

  -- ── nvim-lint: linting ─────────────────────────────────────────
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript      = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript      = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}

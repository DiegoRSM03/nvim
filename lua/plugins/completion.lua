-- ============================================================
-- COMPLETION
-- nvim-cmp: completion engine
-- Sources: LSP, buffer, path, snippets (luasnip)
-- ============================================================
return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",   -- LSP completions
      "hrsh7th/cmp-buffer",     -- words from current buffer
      "hrsh7th/cmp-path",       -- filesystem paths
      "L3MON4D3/LuaSnip",       -- snippet engine
      "saadparwaiz1/cmp_luasnip", -- snippet completions
      "rafamadriz/friendly-snippets", -- collection of common snippets
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Load friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),  -- prev item
          ["<C-j>"] = cmp.mapping.select_next_item(),  -- next item
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),      -- trigger completion
          ["<C-e>"] = cmp.mapping.abort(),             -- close completion
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- confirm only explicit selection
          -- Tab to jump through snippet placeholders
          ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "copilot",  group_index = 1 }, -- Copilot suggestions first
          { name = "nvim_lsp", group_index = 1 },
          { name = "luasnip",  group_index = 1 },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        -- Show completion source labels (e.g. [LSP], [Copilot])
        formatting = {
          format = function(entry, item)
            local source_labels = {
              copilot  = "[Copilot]",
              nvim_lsp = "[LSP]",
              luasnip  = "[Snip]",
              buffer   = "[Buf]",
              path     = "[Path]",
            }
            item.menu = source_labels[entry.source.name] or ""
            return item
          end,
        },
      })
    end,
  },
}

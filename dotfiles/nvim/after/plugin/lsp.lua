local lsp = require('lsp-zero')
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        -- 'rust_analyzer',
        'texlab',
        'lua_ls',
        'matlab_ls',
    },
    -- handlers = {
    --     -- lsp.default_setup,
    --     rust_analyzer=lsp.noop,
    -- },
})

lsp.preset("recommended")


-- lsp.ensure_installed({
-- 	-- 'rust_analyzer',
--     'texlab',
--     'lua_ls',
--     'matlab_ls',
-- })

-- Use rust-tools to load rust_analyzer, use inlay_hints, etc.
-- lsp.skip_server_setup({'rust_analyzer'})

lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_select = {behavior = cmp.SelectBehavior.Select}
cmp.setup({
    mapping = {
        ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
        -- ['<Tab>'] = cmp_action.luasnip_supertab(),
        -- ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
        ['<C-s>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm({select = true}),
        -- ['<C-Space>'] = cmp.mapping.complete(),
    },
    sources = {
        -- {name = "lsp-zero" },
        {name = "nvim_lsp" },
        {name = "luasnip" },
    }
})
-- lsp.setup_nvim_cmp({
--   mapping = cmp_mappings,
-- })
-- Fix Undefined global 'vim'
lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {
      buffer = bufnr,
      remap = false,
      -- remap = true,
  }
  lsp.default_keymaps(opts)

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "gw", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "ge", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>e", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("i", "<C-e>", function() vim.lsp.buf.code_action() end, opts)
  -- vim.keymap.set("n", "gr", require('telescope.builtin').lsp_references, opts)
  vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
  -- vim.keymap.set("n", "gk", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set({"i", "v"}, "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

vim.diagnostic.config({
    virtual_text = true
})

-- local rust_lsp = lsp.build_options('rust_analyzer', {
--     single_file_support = false,
-- })

lsp.setup()
-- require('rust-tools').setup({
--     server = { rust_lsp };
-- })

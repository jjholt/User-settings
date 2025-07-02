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
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    mapping = {
        ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        -- ['<Tab>'] = cmp_action.luasnip_supertab(),
        -- ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
        ['<C-s>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        -- ['<C-Space>'] = cmp.mapping.complete(),
    },
    sources = cmp.config.sources({
        -- {name = "lsp-zero" },
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "path" },
    }, {
        { name = "buffer", keyword_length = 3 },
    }),
})
-- lsp.setup_nvim_cmp({
--   mapping = cmp_mappings,
-- })
-- Fix Undefined global 'vim'
-- vim.lsp.set_preferences({
--     suggest_lsp_servers = false,
--     sign_icons = {
--         error = 'E',
--         warn = 'W',
--         hint = 'H',
--         info = 'I'
--     }
-- })


--
vim.diagnostic.config({
    virtual_text = true
})

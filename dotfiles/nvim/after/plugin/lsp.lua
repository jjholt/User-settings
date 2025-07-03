require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'rust_analyzer',
        'texlab',
        'lua_ls',
        'matlab_ls',
    },
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


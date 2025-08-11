require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        -- 'rust_analyzer',
        'texlab',
        'lua_ls',
        'matlab_ls',
    },
})
vim.lsp.config['matlab_ls'] = {
    -- filetypes = {'matlab'},
    -- root_markers = {'.git'},
    settings = {
        MATLAB = {
            installPath = '$HOME/.local/MATLAB/R2025a'
        },
    },
    single_file_support = true
}
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


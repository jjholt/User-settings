require("custom")

vim.lsp.config('lua_ls', {
    on_attach = function ()
        vim.keymap.set("n", "<leader><leader>", function()
            vim.cmd("so")
        end, {desc = "Shout out. Equivalent to :so"})
    end
})

vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
vim.keymap.set("n", "gw", function() vim.lsp.buf.workspace_symbol() end, opts)
vim.keymap.set("n", "ge", function() vim.diagnostic.open_float() end, opts)
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
vim.keymap.set("n", "<leader>e", function() vim.lsp.buf.code_action() end, opts)
-- vim.keymap.set("n", "gr", require('telescope.builtin').lsp_references, opts)
vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
vim.keymap.set("n", "gk", function() vim.lsp.buf.signature_help() end, opts)
vim.keymap.set({"i", "v"}, "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

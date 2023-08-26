local rt = require('rust-tools')
local extension_path = vim.env.HOME .. '/.local/share/nvim/vadimcn.vscode-lldb-1.9.2/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb'
local this_os = vim.loop.os_uname().sysname;

liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")

local opts = {
    server = {
        settings = {
            ['rust-analyzer'] = {
                checkOnSave = {command = "clippy"},
            },
        },
        on_attach = function (_, bufnr)
            vim.keymap.set("n", "K", function() rt.hover_actions.hover_actions() end, {buffer = bufnr})
        end
    },
    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
            codelldb_path, liblldb_path)
    }
}
rt.setup(opts)

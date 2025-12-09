vim.g.rustaceanvim = {
  server = {
    on_attach = function(client, bufnr)
      -- Prevent rustaceanvim from pushing its own completion provider
      client.server_capabilities.completionProvider = false
    end,
  },
}

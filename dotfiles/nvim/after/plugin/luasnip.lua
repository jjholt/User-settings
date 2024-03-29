local ls = require("luasnip")
local types = require "luasnip.util.types"

ls.config.setup({
    update_events = "TextChanged, TextChangedI",
})
require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/snippets/"})
ls.setup({
  enable_autosnippets = true,
  -- store_selection_keys = "<Tab>",
})

if not pcall(require, "luasnip") then
  return
end

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<Tab>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true, desc = "Next choice" })

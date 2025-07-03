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


-- vim.keymap.set({ "i", "s" }, "<Tab>", function()
--   if ls.choice_active() then
--     ls.change_choice(1)
--   end
-- end, { silent = true, desc = "Next choice" })

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    snippet = {
        expand = function(args)
            ls.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        -- ["<Tab>"] = cmp_action.luasnip_supertab(),
        -- ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
        ["<C-s>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-e>"] = cmp.mapping.complete(),
        ["<C-k>"] = cmp.mapping(function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump(-1)
            end
        end, {"i", "s"}),
        ["<C-j>"] = cmp.mapping(function()
            if ls.locally_jumpable(-1) then
                ls.jump(-1)
            end
        end, {"i", "s"}),
    }),
    sources = cmp.config.sources({
        -- {name = "lsp-zero" },
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" },
        -- { name = "nvim_lua" },
        -- { name = "path" },
    }, {
        { name = "buffer", keyword_length = 3 },
    }),
})

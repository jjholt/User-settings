local ls = require("luasnip")
local fmta = require("luasnip.extras.fmt").fmta
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local s = ls.snippet

return {
    -- s({trig = "\"", snippetType = "autosnippet", wordTrig = false}, fmta([["<>"<>]], {i(1), i(0)}, {})),
    -- s({trig = "[", snippetType = "autosnippet", wordTrig = false}, fmta("[<>]<>", {i(1), i(0)}, {})),
    -- s({trig = "(", snippetType = "autosnippet", wordTrig = false}, fmta("(<>)<>", {i(1), i(0)}, {})),
    -- s({trig = "{", snippetType = "autosnippet", wordTrig = false}, fmta("{<>}<>", {i(1), i(0)}, {})),
    -- s({trig = "<", snippetType = "autosnippet", wordTrig = false}, fmt("<{}>{}", {i(1), i(0)}, {})),
}

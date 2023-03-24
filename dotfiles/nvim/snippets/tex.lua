local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local get_visual = function(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else  -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local tex_utils = {}
tex_utils.in_mathzone = function()  -- math context detection
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex_utils.in_text = function()
  return not tex_utils.in_mathzone()
end
tex_utils.in_env = function(name)  -- generic environment detection
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex_utils.in_itemize = function()  -- itemize environment detection
    return tex_utils.in_env('itemize')
end
tex_utils.in_tikz = function()  -- TikZ picture environment detection
    return tex_utils.in_env('tikzpicture')
end


return {
    s("dx", fmta( "\\frac{d<>}{d<>}<>", {i(1,"y"), i(2,"x"), i(0)}) ),
    s("dp", fmta( "\\frac{\\partial <>}{\\partial <>}<>", {i(1,"y"), i(2,"x"), i(0)}) ),
    s({trig = "([^%a])mm", wordTrig = false, regTrig = true, snippetType = "autosnippet"},
      fmta( "<>$<>$", { f( function(_, snip) return snip.captures[1] end ), d(1, get_visual), })),
    s({trig = '([^%a])ee', regTrig = true, wordTrig = false},
      fmta( "<>e^{<>}", { f( function(_, snip) return snip.captures[1] end ), d(1, get_visual) })),
    s({trig = "dd", snippetType = "autosnippet"}, fmta( "\\draw <> ;<>", { i(1), i(0)}), { condition = tex_utils.in_tikz }),
    s({trig = "int", snippetType = "autosnippet"},
        fmta("\\int_{<>}^{<>} <> \\diff <> <>", {i(1),i(2),i(4),i(3,"x"), i(0)}, {condition = tex_utils.in_mathzone})),
    s("vv", fmta("\\vec{<>}<>", {i(1),i(0)}, {condition = tex_utils.in_mathzone})),
    s("hh", fmta("\\hat{<>}<>", {i(1),i(0)}, {condition = tex_utils.in_mathzone})),


    s({trig = ";.", snippetType = "autosnippet"}, fmta("\\cdot", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";8", snippetType = "autosnippet"}, fmta("\\infty", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";6", snippetType = "autosnippet"}, fmta("\\partial", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";/", snippetType = "autosnippet"}, fmta("\\frac{$1}{$2}$0", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";%", snippetType = "autosnippet"}, fmta("\\frac{$1}{$2}$0", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";@", snippetType = "autosnippet"}, fmta("\\circ", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";0", snippetType = "autosnippet"}, fmta("^\\circ", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";;", snippetType = "autosnippet"}, fmta("\\dot{<>}<>", {i(1),i(0)}, {condition = tex_utils.in_mathzone})),
    s({trig = ";;;", snippetType = "autosnippet"}, fmta("\\ddot{<>}<>", {i(1),i(0)}, {condition = tex_utils.in_mathzone})),
    s({trig = ";=", snippetType = "autosnippet"}, fmta("\\equiv", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";*", snippetType = "autosnippet"}, fmta("\\times", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";<", snippetType = "autosnippet"}, fmta("\\leq", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";>", snippetType = "autosnippet"}, fmta("\\geq", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";2", snippetType = "autosnippet"}, fmta("\\sqrt{<>}<>", {i(1),i(0)}, {condition = tex_utils.in_mathzone})),
    s({trig = ";3", snippetType = "autosnippet"}, fmta("\\sqrt[3]{<>}<>", {i(1),i(0)}, {condition = tex_utils.in_mathzone})),
    s({trig = ";|", snippetType = "autosnippet"}, fmta("\\Big|", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";+", snippetType = "autosnippet"}, fmta("\\bigcup", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";-", snippetType = "autosnippet"}, fmta("\\bigcap", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";,", snippetType = "autosnippet"}, fmta("\\nonumber", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";a", snippetType = "autosnippet"}, fmta("\\alpha", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";b", snippetType = "autosnippet"}, fmta("\\beta", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";c", snippetType = "autosnippet"}, fmta("\\chi", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";d", snippetType = "autosnippet"}, fmta("\\delta", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";e", snippetType = "autosnippet"}, fmta("\\epsilon", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";ve", snippetType = "autosnippet"}, fmta("\\varepsilon", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";f", snippetType = "autosnippet"}, fmta("\\phi", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";vf", snippetType = "autosnippet"}, fmta("\\varphi", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";g", snippetType = "autosnippet"}, fmta("\\gamma", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";h", snippetType = "autosnippet"}, fmta("\\eta", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";i", snippetType = "autosnippet"}, fmta("\\iota", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";k", snippetType = "autosnippet"}, fmta("\\kappa", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";l", snippetType = "autosnippet"}, fmta("\\lambda", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";m", snippetType = "autosnippet"}, fmta("\\mu", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";n", snippetType = "autosnippet"}, fmta("\\nu", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";p", snippetType = "autosnippet"}, fmta("\\pi", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";vp", snippetType = "autosnippet"}, fmta("\\varpi", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";q", snippetType = "autosnippet"}, fmta("\\theta", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";vq", snippetType = "autosnippet"}, fmta("\\vartheta", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";r", snippetType = "autosnippet"}, fmta("\\rho", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";vr", snippetType = "autosnippet"}, fmta("\\varrho", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";s", snippetType = "autosnippet"}, fmta("\\sigma", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";vs", snippetType = "autosnippet"}, fmta("\\varsigma", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";t", snippetType = "autosnippet"}, fmta("\\tau", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";u", snippetType = "autosnippet"}, fmta("\\upsilon", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";o", snippetType = "autosnippet"}, fmta("\\omega", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";&", snippetType = "autosnippet"}, fmta("\\wedge", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";x", snippetType = "autosnippet"}, fmta("\\xi", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";y", snippetType = "autosnippet"}, fmta("\\psi", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";z", snippetType = "autosnippet"}, fmta("\\zeta", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";D", snippetType = "autosnippet"}, fmta("\\Delta", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";F", snippetType = "autosnippet"}, fmta("\\Phi", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";G", snippetType = "autosnippet"}, fmta("\\Gamma", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";Q", snippetType = "autosnippet"}, fmta("\\Theta", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";L", snippetType = "autosnippet"}, fmta("\\Lambda", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";P", snippetType = "autosnippet"}, fmta("\\Pi", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";X", snippetType = "autosnippet"}, fmta("\\Xi", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";Y", snippetType = "autosnippet"}, fmta("\\Psi", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";S", snippetType = "autosnippet"}, fmta("\\Sigma", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";U", snippetType = "autosnippet"}, fmta("\\Upsilon", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";O", snippetType = "autosnippet"}, fmta("\\Omega", {}, {condition = tex_utils.in_mathzone})),
    s({trig = ";(", snippetType = "autosnippet"}, fmta("\\left( <> \\right) <>", {i(1), i(0)}, {condition = tex_utils.in_mathzone})),
    s({trig = ";{", snippetType = "autosnippet"}, fmta("\\left\\{ <> \\right\\} <>", {i(1), i(0)}, {condition = tex_utils.in_mathzone})),
    s({trig = ";[", snippetType = "autosnippet"}, fmta("\\left[ <> \\right] <>", {i(1), i(0)}, {condition = tex_utils.in_mathzone})),
}

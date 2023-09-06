local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local l = require("luasnip.extras").lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else  -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local tex = {}
tex.in_mathzone = function()  -- math context detection
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex.in_text = function()
  return not tex.in_mathzone()
end
tex.in_env = function(name)  -- generic environment detection
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex.in_itemize = function()  -- itemize environment detection
    return tex.in_env('itemize')
end
tex.in_tikz = function()  -- TikZ picture environment detection
    return tex.in_env('tikzpicture')
end

return {
    s({trig = "(%w+)%s+(%w+)\\", wordTrig = false, regTrig = true},
      fmta( "\\<>{<>}{<>}<>", {
          i(1),
          f( function(_, snip) return snip.captures[1] end ),
          f( function(_, snip) return snip.captures[2] end ),
          i(0),
      })),

    s({trig = "(%d+)/", wordTrig = false, regTrig = true},
    fmta( "\\frac{<>}{<>}<>", {
        f( function(_, snip) return snip.captures[1] end ),
        i(1),
        i(0),
    })),

    s({trig = "sse", dscr = "Create Section"}, fmta( "\\section{<>}<>", {i(1), i(0)}), {}),
    s({trig = "sss", dscr = "Create Subsection"}, fmta( "\\subsection{<>}<>", {i(1), i(0)}), {}),
    s({trig = "ss2", dscr = "Create Subsubsection"}, fmta( "\\subsubsection{<>}<>", {i(1), i(0)}), {}),
    s({trig = "spg", dscr = "Create Paragraph"}, fmta( "\\paragraph{<>}<>", {i(1), i(0)}), {}),
    s({trig = "sch", dscr = "Create Chapter"}, fmta( "\\chapter{<>}<>", {i(1), i(0)}), {}),

    s({trig = "beg", dscr = "Begin a new environment"}, fmta( "\\begin{<>}\n\t<>\n\\end{<>}<>", {i(1), i(2), i(1), i(0)}), {}),
    s({trig = "beq", dscr = "Equation environment"}, fmta( "\\begin{equation}\n\t<>\n\\end{equation}<>", {i(1), i(0)}), {}),
    s({trig = "bseq", dscr = "Equation* environment"}, fmta( "\\begin{equation*}\n\t<>\n\\end{equation*}<>", {i(1), i(0)}), {}),
    s({trig = "bcas", dscr = "Cases environment for pairs of equations"}, fmta( "\\begin{cases}\n\t<>\n\\end{cases}<>", {i(1), i(0)}), {}),
    s({trig = "bal", dscr = "Align environment"}, fmta( "\\begin{align}\n\t<>\n\\end{align}<>", {i(1), i(0)}), {}),
    s({trig = "bsal", dscr = "Align* environment"}, fmta( "\\begin{align*}\n\t<>\n\\end{align*}<>", {i(1), i(0)}), {}),
    s({trig = "btik", dscr = "Tikzpicture environment"}, fmta("\\begin{tikzpicture}\n\t<>\n\\end{tikzpicture}<>", {i(1),i(0)})),
    s({trig = "sfig", dscr = "Subfigure"}, fmta("\\begin{subfigure}[<>]{<>}\n\\centering\n\t\\includegraphics[<>]{figures/<>}\n\\caption{<>}\n\\label{fig:<>}\n\\end{subfigure}<>", {
        c(1, {t"b", t"t"}),
        i(2, "0.5\\textwidth"),
        c(3, {
            fmta("<>width=<>", {i(1), i(2, "\\textwidth")}),
            fmta("<>height=<>", {i(1), i(2, "4cm")}),
        }),
        i(4),
        i(5),
        l(l._1:match("[^/]*$"):gsub(" ", "-"):lower(), 4),
        i(0)
    })),
    s({trig = "fig", dscr = "Figure"}, fmta("\\begin{figure}[<>]\\centering\n\t\\includegraphics[<>]{figures/<>}\n\\caption{<>}\n\\label{fig:<>}\n\\end{figure}<>", {
        c(1, {t"h", t"", t"t", t"b"}),
        c(2, {
            fmta("<>width=<>", {i(1), i(2, "0.5\\textwidth")}),
            fmta("<>height=<>", {i(1), i(2, "4cm")}),
        }),
        i(3),
        i(4),
        l(l._1:match("[^/]*$"):gsub(" ", "-"):lower(), 3),
        i(0)
    })),
    s({trig = "bit", dscr = "Itemize"}, fmta( "\\begin{itemize}\n\t<>\n\\end{itemize}<>", {i(1), i(0)}), {}),
    s({trig = "ben", dscr = "Enumerate"}, fmta( "\\begin{enumerate}\n\t<>\n\\end{enumerate}<>", {i(1), i(0)}), {}),
    s({trig = "ii", dscr = "New item"}, fmta( "\\item ", {})),


    s("dx", fmta( "\\frac{d<>}{d<>}<>", {i(1,"y"), i(2,"x"), i(0)}) , {condition = tex.in_mathzone}),
    s("dp", fmta( "\\frac{\\partial <>}{\\partial <>}<>", {i(1,"y"), i(2,"x"), i(0)}), {condition = tex.in_mathzone}),
    s({trig = "([^%a])mm", wordTrig = false, regTrig = true, snippetType = "autosnippet"},
      fmta( "<>$<>$", { f( function(_, snip) return snip.captures[1] end ), d(1, get_visual), })),
    s({trig = "dd", snippetType = "autosnippet"}, fmta( "\\draw <> ;<>", { i(1), i(0)}), { condition = tex.in_tikz }),
    s("int", fmta("\\int_{<>}^{<>} <> \\diff <> <>", {i(1),i(2),i(4),i(3,"x"), i(0)}, {condition = tex.in_mathzone})),
    s("vv", fmta("\\vec{<>}<>", {i(1),i(0)}, {condition = tex.in_mathzone})),
    s("hh", fmta("\\hat{<>}<>", {i(1),i(0)}, {condition = tex.in_mathzone})),
    -- s("SI", fmta("\\SI{<>}{<>}<>", {i(1), i(2) ,i(0)}, {})),

    s({trig = "`", snippetType = "autosnippet"}, fmta("`<>'<>", {i(1),i(0)}, {})),
    s({trig = ";.", snippetType = "autosnippet"}, fmta("\\cdot", {}, {condition = tex.in_mathzone})),
    s({trig = ";8", snippetType = "autosnippet"}, fmta("\\infty", {}, {condition = tex.in_mathzone})),
    s({trig = ";6", snippetType = "autosnippet"}, fmta("\\partial", {}, {condition = tex.in_mathzone})),
    s({trig = ";/", snippetType = "autosnippet"}, fmta("\\frac{<>}{<>}<>", {i(1), i(2), i(0)}, {condition = tex.in_mathzone})),
    s({trig = ";@", snippetType = "autosnippet"}, fmta("\\circ", {}, {condition = tex.in_mathzone})),
    s({trig = ";0", snippetType = "autosnippet"}, fmta("^\\circ", {}, {condition = tex.in_mathzone})),
    s({trig = ";;", snippetType = "autosnippet"}, fmta("\\dot{<>}<>", {i(1),i(0)}, {condition = tex.in_mathzone})),
    s({trig = ";;;", snippetType = "autosnippet"}, fmta("\\ddot{<>}<>", {i(1),i(0)}, {condition = tex.in_mathzone})),
    s({trig = ";=", snippetType = "autosnippet"}, fmta("\\equiv", {}, {condition = tex.in_mathzone})),
    s({trig = ";*", snippetType = "autosnippet"}, fmta("\\times", {}, {condition = tex.in_mathzone})),
    s({trig = ";<", snippetType = "autosnippet"}, fmta("\\leq", {}, {condition = tex.in_mathzone})),
    s({trig = ";>", snippetType = "autosnippet"}, fmta("\\geq", {}, {condition = tex.in_mathzone})),
    s({trig = ";2", snippetType = "autosnippet"}, fmta("\\sqrt{<>}<>", {i(1),i(0)}, {condition = tex.in_mathzone})),
    s({trig = ";3", snippetType = "autosnippet"}, fmta("\\sqrt[3]{<>}<>", {i(1),i(0)}, {condition = tex.in_mathzone})),
    s({trig = ";|", snippetType = "autosnippet"}, fmta("\\Big|", {}, {condition = tex.in_mathzone})),
    s({trig = ";+", snippetType = "autosnippet"}, fmta("\\bigcup", {}, {condition = tex.in_mathzone})),
    s({trig = ";-", snippetType = "autosnippet"}, fmta("\\bigcap", {}, {condition = tex.in_mathzone})),
    s({trig = ";,", snippetType = "autosnippet"}, fmta("\\nonumber", {}, {condition = tex.in_mathzone})),
    s({trig = ";a", snippetType = "autosnippet"}, fmta("\\alpha", {}, {condition = tex.in_mathzone})),
    s({trig = ";b", snippetType = "autosnippet"}, fmta("\\beta", {}, {condition = tex.in_mathzone})),
    s({trig = ";c", snippetType = "autosnippet"}, fmta("\\chi", {}, {condition = tex.in_mathzone})),
    s({trig = ";d", snippetType = "autosnippet"}, fmta("\\delta", {}, {condition = tex.in_mathzone})),
    s({trig = ";e", snippetType = "autosnippet"}, fmta("\\epsilon", {}, {condition = tex.in_mathzone})),
    s({trig = ";ve", snippetType = "autosnippet"}, fmta("\\varepsilon", {}, {condition = tex.in_mathzone})),
    s({trig = ";f", snippetType = "autosnippet"}, fmta("\\phi", {}, {condition = tex.in_mathzone})),
    s({trig = ";vf", snippetType = "autosnippet"}, fmta("\\varphi", {}, {condition = tex.in_mathzone})),
    s({trig = ";g", snippetType = "autosnippet"}, fmta("\\gamma", {}, {condition = tex.in_mathzone})),
    s({trig = ";h", snippetType = "autosnippet"}, fmta("\\eta", {}, {condition = tex.in_mathzone})),
    s({trig = ";i", snippetType = "autosnippet"}, fmta("\\iota", {}, {condition = tex.in_mathzone})),
    s({trig = ";k", snippetType = "autosnippet"}, fmta("\\kappa", {}, {condition = tex.in_mathzone})),
    s({trig = ";l", snippetType = "autosnippet"}, fmta("\\lambda", {}, {condition = tex.in_mathzone})),
    s({trig = ";m", snippetType = "autosnippet"}, fmta("\\mu", {}, {condition = tex.in_mathzone})),
    s({trig = ";n", snippetType = "autosnippet"}, fmta("\\nu", {}, {condition = tex.in_mathzone})),
    s({trig = ";p", snippetType = "autosnippet"}, fmta("\\pi", {}, {condition = tex.in_mathzone})),
    s({trig = ";vp", snippetType = "autosnippet"}, fmta("\\varpi", {}, {condition = tex.in_mathzone})),
    s({trig = ";q", snippetType = "autosnippet"}, fmta("\\theta", {}, {condition = tex.in_mathzone})),
    s({trig = ";vq", snippetType = "autosnippet"}, fmta("\\vartheta", {}, {condition = tex.in_mathzone})),
    s({trig = ";r", snippetType = "autosnippet"}, fmta("\\rho", {}, {condition = tex.in_mathzone})),
    s({trig = ";vr", snippetType = "autosnippet"}, fmta("\\varrho", {}, {condition = tex.in_mathzone})),
    s({trig = ";s", snippetType = "autosnippet"}, fmta("\\sigma", {}, {condition = tex.in_mathzone})),
    s({trig = ";vs", snippetType = "autosnippet"}, fmta("\\varsigma", {}, {condition = tex.in_mathzone})),
    s({trig = ";t", snippetType = "autosnippet"}, fmta("\\tau", {}, {condition = tex.in_mathzone})),
    s({trig = ";u", snippetType = "autosnippet"}, fmta("\\upsilon", {}, {condition = tex.in_mathzone})),
    s({trig = ";o", snippetType = "autosnippet"}, fmta("\\omega", {}, {condition = tex.in_mathzone})),
    s({trig = ";&", snippetType = "autosnippet"}, fmta("\\wedge", {}, {condition = tex.in_mathzone})),
    s({trig = ";x", snippetType = "autosnippet"}, fmta("\\xi", {}, {condition = tex.in_mathzone})),
    s({trig = ";y", snippetType = "autosnippet"}, fmta("\\psi", {}, {condition = tex.in_mathzone})),
    s({trig = ";z", snippetType = "autosnippet"}, fmta("\\zeta", {}, {condition = tex.in_mathzone})),
    s({trig = ";D", snippetType = "autosnippet"}, fmta("\\Delta", {}, {condition = tex.in_mathzone})),
    s({trig = ";F", snippetType = "autosnippet"}, fmta("\\Phi", {}, {condition = tex.in_mathzone})),
    s({trig = ";G", snippetType = "autosnippet"}, fmta("\\Gamma", {}, {condition = tex.in_mathzone})),
    s({trig = ";Q", snippetType = "autosnippet"}, fmta("\\Theta", {}, {condition = tex.in_mathzone})),
    s({trig = ";L", snippetType = "autosnippet"}, fmta("\\Lambda", {}, {condition = tex.in_mathzone})),
    s({trig = ";P", snippetType = "autosnippet"}, fmta("\\Pi", {}, {condition = tex.in_mathzone})),
    s({trig = ";X", snippetType = "autosnippet"}, fmta("\\Xi", {}, {condition = tex.in_mathzone})),
    s({trig = ";Y", snippetType = "autosnippet"}, fmta("\\Psi", {}, {condition = tex.in_mathzone})),
    s({trig = ";S", snippetType = "autosnippet"}, fmta("\\Sigma", {}, {condition = tex.in_mathzone})),
    s({trig = ";U", snippetType = "autosnippet"}, fmta("\\Upsilon", {}, {condition = tex.in_mathzone})),
    s({trig = ";O", snippetType = "autosnippet"}, fmta("\\Omega", {}, {condition = tex.in_mathzone})),
    s({trig = ";(", snippetType = "autosnippet"}, fmta("\\left( <> \\right) <>", {i(1), i(0)}, {condition = tex.in_mathzone})),
    s({trig = ";{", snippetType = "autosnippet"}, fmta("\\left\\{ <> \\right\\} <>", {i(1), i(0)}, {condition = tex.in_mathzone})),
    s({trig = ";[", snippetType = "autosnippet"}, fmta("\\left[ <> \\right] <>", {i(1), i(0)}, {condition = tex.in_mathzone})),
}

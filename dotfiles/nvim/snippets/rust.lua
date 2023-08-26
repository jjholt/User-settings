local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local t = ls.text_node
local fmta = require("luasnip.extras.fmt").fmta

local get_visual = function(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else  -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end


return {
    s("tsk", fmta( "#[test]\nfn <>() {\n\t<>\n}\n<>", {i(1), i(2,"unimplemented!()"),i(0)}) ),
    s("tcfg", fmta( "#[cfg(test)]\nmod test {\n\tuse super::*;\n\t<>\n}<>", {
            i(1),
            i(0)
    })),
    s("sn", fmta( "String::new()<>", {i(0)}) ),
    s("sf", fmta( "String::from(<>)<>", {i(1), i(0)}) ),
    s("pl", fmta( "println!(\"<>\", <>)<>", {
        c(1, {
            fmta("<>{<>}", {i(1), i(2)}),
            fmta("<>{:#?}", {i(1)}),
            t""
        }), i(2), i(0),
    })),
    s("dv", fmta( "#[derive(<>)]<>", {i(1), i(0)}) ),
}

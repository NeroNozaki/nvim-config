local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
  s('template', {
    t 'const std = @import("std");',
    t {'', '', ''},
    t 'pub fn main() !void',
    t { ' {', '\t' },
    i(0),
    t { '', '}' },
  }),
}


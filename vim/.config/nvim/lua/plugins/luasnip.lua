return {
	"L3MON4D3/LuaSnip",
	event = "InsertEnter",
	dependencies = {
		"rafamadriz/friendly-snippets",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	config = function()
		local ls = require("luasnip")
		local s = ls.snippet
		-- local sn = ls.snippet_node
		-- local isn = ls.indent_snippet_node
		local t = ls.text_node
		local i = ls.insert_node
		local f = ls.function_node
		-- local c = ls.choice_node
		-- local d = ls.dynamic_node
		-- local r = ls.restore_node
		-- local events = require("luasnip.util.events")
		-- local ai = require("luasnip.nodes.absolute_indexer")
		-- local fmt = require("luasnip.extras.fmt").fmt
		-- local m = require("luasnip.extras").m
		-- local lambda = require("luasnip.extras").l

		local am = require("extensions.algomonad")

		ls.add_snippets("cpp", {
			s("lc", {
				t({
					"#include <string>",
					"#include <vector>",
					"#include <queue>",
					"#include <unordered_set>",
					"#include <unordered_map>",
					"#include <set>",
					"#include <map>",
					"#include <iostream>",
					"#include <array>",
					"using namespace std;",
				}),
			}),
			s("cvec", {
				t({ "std::for_each(" }),
				i(1, "vec"),
				t({ ".begin(), " }),
				f(function(args)
					return args[1][1]
				end, { 1 }),
				t({ ".end(), [&](auto e) { std::cout << e << std::endl; });" }),
			}),
			s("cout", {
				t({ "std::cout << " }),
				i(1, "res"),
				t({ " << std::endl;" }),
			}),
		})
		ls.add_snippets("python", {
			s("lc", {
				t({
					"from typing import List, Dict, Tuple, Optional",
					"from heapq import heapify, heappush, heappop",
					"from collections import Counter, defaultdict, deque",
				}),
			}),
		})
		for _, ft in pairs({ "typescriptreact", "typescript", "javascriptreact", "javascript" }) do
			ls.add_snippets(ft, {
				s("cl", {
					t({ "console.log(" }),
					i(1),
					t({ ")" }),
				}),
			})
		end
		ls.add_snippets("go", {
			s("lc", {
				t({ "package main" }),
			}),
			s("amain", {
				t({ "// >>>", "func main() {", "" }),
				i(1),
				t({ "", "}", "// <<<" }),
			}),
			s("minmax", {
				t({
					"type numbers interface {",
					"	int | int8 | int16 | int32 | int64 | float32 | float64",
					"}",
					"",
					"func min[T numbers](a, b T) T {",
					"	if a < b {",
					"		return a",
					"	}",
					"	return b",
					"}",
					"func max[T numbers](a, b T) T {",
					"	if a > b {",
					"		return a",
					"	}",
					"	return b",
					"}",
				}),
			}),
		})
		ls.add_snippets("rust", {
			s("lc", {
				f(am.comment_with_open_identifier),
				t({ "", "" }),
				f(function()
					return "struct " .. am.get_rust_impl_name() .. ";"
				end),
				t({ "", "" }),
				f(am.comment_with_close_identifier),
			}),
			s("amain", {
				t({ "// >>>", "fn main() {", "" }),
				i(1),
				t({ "", "}", "// <<<" }),
			}),
		})
		ls.add_snippets("all", {
			s("amo", {
				f(am.comment_with_open_identifier),
			}),
			s("amc", {
				f(am.comment_with_close_identifier),
			}),
		})
		ls.config.set_config({
			history = false,
			update_events = "TextChanged,TextChangedI",
			region_check_events = "CursorMoved",
		})
	end,
}

local present, luasnip = pcall(require, "luasnip")
if not present then
	return
end

luasnip.config.set_config({
	history = false,
	-- update_events = "TextChanged,TextChangedI",
})
require("luasnip.loaders.from_vscode").lazy_load()

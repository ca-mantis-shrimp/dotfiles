-- [nfnl] generation_test.fnl
local config = {
	items = { { "a", "b" }, { "c", "d" } },
	nested = { data = { { "x", "y" } } },
	more = { stuff = { { "foo", "bar" }, { "baz", "qux" } } },
}
return print(config)

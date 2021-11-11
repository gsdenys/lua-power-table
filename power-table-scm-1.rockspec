package = "power-table"
version = "scm-1"

source = {
	url = "git://github.com/gsdenys/lua-power-table",
}

description = {
	summary = "A lua library to iterate over tables",
	detailed = [[
		This library extends the common Lua table by adding iterators function.
	]],
	homepage = "https://github.com/gsdenys/lua-power-table",
	license = "MIT",
}

dependencies = {
    "lua",
}

build = {
    type = "builtin",
    modules = {
        ['ptable'] = "src/table.lua",

		['ptable.helper'] = "src/helper.lua",

		['ptable.operations.basic'] = "src/operations/basic.lua",
		['ptable.operations.kv'] = "src/operations/key_value.lua",
    },
}
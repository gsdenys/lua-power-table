# lua-power-table

![build status](https://github.com/gsdenys/lua-power-table/workflows/build/badge.svg)
[![Coverage Status](https://coveralls.io/repos/github/gsdenys/lua-power-table/badge.svg?branch=main)](https://coveralls.io/github/gsdenys/lua-power-table?branch=main)
![License](https://img.shields.io/badge/license-MIT-green)
![LuaRocks](https://img.shields.io/luarocks/v/gsdenys/power-table)


A table extension for lua

## Usage

As this is a general propose tale extention you can it import locally or globaly. Follow command bellow to know how to use it.

```lua
local table = require "ptable"
local tbl = table({})

tbl.info() 
```

For more methods documentation go to the [documentation page](https://gsdenys.github.io/lua-power-table)

### Documentation

To generate documentation use the command below. Then push them to this repo. So, it'll be rendered at the page [https://gsdenys.github.io/lua-power-table/](https://gsdenys.github.io/lua-power-table/).

```bash
ldoc . -d docs/
```

## License

Lua Power Table is free software and uses the [MIT license](https://github.com/gsdenys/lua-power-table/blob/main/LICENSE), the same as Lua 5.x.

---print library information
local function info()
    print [[
       lua-power-table [
          version: 1.0,
          author: Denys G. Santos <gsdenys@gmail.com>,
          github: https://github.com/gsdenys/lua-power-table
       ]
       ]]
end

---do nothing
local function void() end

return {info = info, void = void}
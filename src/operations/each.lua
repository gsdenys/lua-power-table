local assertion = require "ptable.assertion"

-- add helper module to possibilitate to get the executed function name
local helper = require "ptable.utils.helper"

---Apply the given function to all the values of the table
---@param t any the table to iteract
---@param func any the function to aply
---@return any
local function eachi(t, func, ...)
    assertion.Func(helper.function_name(), t, func)

    local v = t:values()
    for i = 1, #t do func(v[i], ...) end
end

---Apply the given function to all the keys of the table
---@param t any the table to iteract
---@param func any the function to aply
---@return any
local function eachk(t, func, ...)
    assertion.Func(helper.function_name(), t, func)

    local keys = t:keys()
    for i = 1, #t do func(keys[i], ...) end
end

---Apply the given function on all (key, value) pairs of table
---@param t any the table to iteract
---@param func any the function to aply
---@return any
local function each(t, func, ...)
    assertion.Func(helper.function_name(), t, func)

    for k, v in pairs(t) do func(k, v, ...) end
end

return {eachi = eachi, eachk = eachk, each = each}

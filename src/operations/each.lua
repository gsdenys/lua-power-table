local assertion = require "ptable.assertion"

---Apply the given function to all the values of the table
---@param t any the table to iteract
---@param func any the function to aply
---@return any
local function eachi(t, func, ...)
    assertion.Func("eachi", t, func)

    for i = 1, #t do func(t[i], ...) end

    return t
end

---Apply the given function to all the keys of the table
---@param t any the table to iteract
---@param func any the function to aply
---@return any
local function eachk(t, func, ...)
    assertion.Func("eachk", t, func)

    local keys = t:keys()

    for i = 1, #t do func(keys[i], ...) end

    return t
end

---Apply the given function on all (key, value) pairs of table
---@param t any the table to iteract
---@param func any the function to aply
---@return any
local function each(t, func, ...)
    assertion.Func("each", t, func)

    for k, v in pairs(t) do func(k, v, ...) end

    return t
end

return {eachi = eachi, eachk = eachk, each = each}

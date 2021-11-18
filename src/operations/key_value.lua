local TABLE_NAME = "ptable"
local assertion = require "ptable.assertion"

-- add helper module to possibilitate to get the executed function name
local helper = require "ptable.utils.helper"

---get_keys function to get the keys stored in a keys set
---@param t any the table
---@return table - the keyset
local function get_keys(t)
    assertion.Table(t, helper.function_name())

    local keyset = {}
    local index = 1

    for key, _ in pairs(t) do
        keyset[index] = key
        index = index + 1
    end

    return keyset
end

---get_values function to get the keys stored in a values set
---@param t any the table
---@return table - the keyset
local function get_values(t)
    assertion.Table(t, helper.function_name())

    local valueset = {}
    local index = 1

    for _, value in pairs(t) do
        if type(value) == 'table' then value = require(TABLE_NAME)(value) end

        valueset[index] = value
        index = index + 1
    end

    return valueset
end

-- return the methods
return {keys = get_keys, values = get_values}

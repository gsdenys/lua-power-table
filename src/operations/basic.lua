local types = require "ptable.utils.types"
local assertion = require "ptable.assertion"

-- add helper module to possibilitate to get the executed function name
local helper = require "ptable.utils.helper"

local format = string.format
local concat = table.concat

---Size method to messure the length of table
---@param t any
---@return integer
local function size(t)
    assertion.Table(t, helper.function_name())

    local i = 0
    for _ in pairs(t) do i = i + 1 end
    return i
end

---get function to obtain element from table.
---@param tbl any
---@param key any
---@return any
local function get(tbl, key)
    assertion.Table(tbl, helper.function_name())

    local value = tbl[key]

    if value == nil then return nil end

    if type(value) == types.TABLE then
        local t = require(types.POWER_TABLE)
        return t(value)
    end

    return value
end

---equals function that compare the table with another
---@param tbl any the original table
---@param compare any the table to be compared
---@return boolean - true encase of equals, other else false
local function equals(tbl, compare)
    local FUNCTION_NAME = helper.function_name()

    assertion.Table(tbl, FUNCTION_NAME)
    assertion.Table(compare, FUNCTION_NAME)

    if size(tbl) ~= size(compare) then return false end

    for k, v in pairs(tbl) do
        if type(v) ~= type(compare[k]) then return false end

        if type(v) == types.TABLE then
            if not equals(v, compare[k]) then return false end
        else
            if compare[k] ~= v then return false end
        end
    end

    return true
end

---Clone function generates a copy of selected table
---@param tbl any the table to be clonned
---@return table - the clonned table
local function clone(tbl)
    assertion.Table(tbl, helper.function_name())

    local t = require(types.POWER_TABLE)

    local copy = t({})

    for k, v in pairs(tbl) do
        if type(v) == types.TABLE then v = clone(v) end

        copy[k] = v
    end

    return copy
end

---merge two tables in the first one. if the overwrite flag is true, the first
---table value will be overwrited by the second one
---@param t any - the first table
---@param tbl any - the table to be merged
---@param overwrite boolean - overwrite flag
local function merge(t, tbl, overwrite)
    local FUNCTION_NAME = helper.function_name()

    assertion.Table(t, FUNCTION_NAME)
    assertion.Table(tbl, FUNCTION_NAME)

    overwrite = (overwrite == nil and true) or overwrite

    for index, value in pairs(tbl) do
        if t[index] == nil or overwrite then
            if type(value) == types.TABLE then value = clone(value) end
            t[index] = value
        end
    end
end

local string_parts = {
    NIL_VALUE = '',
    TABULATION = "  ",
    ITEM_STRING = "%skey: %s, value: %s",
    TABLE_START = "table [",
    CLOSE_BRACKETS = "]",
    NEW_LINE = "\n"
}

---tostring function that returns a string representation of the given table
---@param t table the table to be converted to string
---@param tab string the number of tabs (2 spaces each one)
---@return string - the table converted to string
local function tostring(t, tab)
    assertion.Table(t, helper.function_name())

    tab = tab or string_parts.TABULATION

    local b = {string_parts.TABLE_START}
    local i = 2

    for k, v in pairs(t) do
        local value_type = type(v)

        if value_type ~= types.FUNCTION then
            if v == nil then v = string_parts.NIL_VALUE end

            if value_type == types.TABLE then
                local table_str = tostring(v, tab .. string_parts.TABULATION)
                b[i] = format(string_parts.ITEM_STRING, tab, k, table_str)
            elseif value_type ~= types.USER_DATA then
                b[i] = format(string_parts.ITEM_STRING, tab, k, v)
            end

            i = i + 1
        end
    end

    b[i] = (tab .. string_parts.CLOSE_BRACKETS):sub(3)

    return concat(b, string_parts.NEW_LINE)
end

-- returns the methods
return {
    get = get,
    size = size,
    clone = clone,
    equals = equals,
    merge = merge,
    tostring = tostring
}

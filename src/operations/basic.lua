local types = require "ptable.utils.types"
local assertion = require "ptable.assertion"

local format = string.format
local concat = table.concat

local TABLE_NAME = "ptable"

---Size method to messure the length of table
---@param t any
---@return integer
local function size(t)
    local i = 0
    for k in pairs(t) do i = i + 1 end
    return i
end

---get function to obtain element from table.
---@param tbl any
---@param key any
---@return any
local function get(tbl, key)
    local value = tbl[key]

    if value == nil then return nil end

    if type(value) == types.TABLE then
        local t = require(TABLE_NAME)
        return t(value)
    end

    return value
end

---equals function that compare the table with another
---@param tbl any the original table
---@param compare any the table to be compared
---@return boolean - true encase of equals, other else false
local function equals(tbl, compare)
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
    assertion.Table(tbl)
    local t = require(TABLE_NAME)

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
    overwrite = (overwrite == nil and true) or  overwrite

    for index, value in pairs(tbl) do
        if t[index] == nil or overwrite then
            if type(value) == types.TABLE then value = clone(value) end
            t[index] = value
        end
    end
end

---tostring function that returns a string representation of the given table
---@param t table the table to be converted to string
---@param tab string the number of tabs (2 spaces each one)
---@return string - the table converted to string 
local function tostring(t, tab)
    local NIL_VALUE = ''
    local TAB_STR = "  "
    local ITEM_STR = "%skey: %s, value: %s"

    tab = tab or TAB_STR

    local b = {"table ["}
    local i = 2

    for k, v in pairs(t) do
        if v == nil then
            v = NIL_VALUE
        elseif type(v) == types.TABLE then
            ---@diagnostic disable: undefined-field
            b[i] = format(ITEM_STR, tab, k, tostring(v, tab .. TAB_STR))
        elseif type(v) ~= types.USER_DATA then
            b[i] = format(ITEM_STR, tab, k, v)
        end

        i = i + 1
    end

    b[i] = (tab .. "]"):sub(3)

    return concat(b, "\n")
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

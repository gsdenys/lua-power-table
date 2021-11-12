local format = string.format
local concat = table.concat

local TABLE_NAME = "ptable"

local function size(t)
    local i = 0
    for k in pairs(t) do i = i + 1 end
    return i
end

local function get(tbl, key)
    local value = tbl[key]

    if value == nil then return nil end

    if type(value) == "table" then
        local t = require(TABLE_NAME)
        return t(value)
    end

    return value
end

local function equals(tbl, compare)
    if size(tbl) ~= size(compare) then return false end

    for k, v in pairs(tbl) do
        if type(v) ~= type(compare[k]) then return false end

        if type(v) == "table" then
            if not equals(v, compare[k]) then return false end
        else
            if compare[k] ~= v then return false end
        end
    end

    return true
end

local function clone(tbl)
    local copy = require(TABLE_NAME)({})

    for k, v in pairs(tbl) do
        if type(v) == "table" then v = clone(v) end

        copy:insert(k, v)
    end
end

local function merge(t, tbl, overwrite)
    overwrite = overwrite or true

    for index, value in ipairs(tbl) do
        if t[index] == nil or overwrite then
            if type(value) == "table" then value = clone(value) end
            t[index] = value
        end
    end
end

---tostring function that returns a string representation of the given table
---@param t table the table to be converted to string
---@param tab string the number of tabs (2 spaces each one)
---@return string - the table converted to string 
local function tostring(t, tab)
    tab = tab or "  "
    local itemstr = "%skey: %s, value: %s"

    local b = {"table ["}
    local i = 2

    for k, v in pairs(t) do
        if v == nil then
            v = ''
        elseif type(v) == "table" then
            ---@diagnostic disable: undefined-field
            b[i] = format(itemstr, tab, k, tostring(v, tab .. "  "))
        elseif type(v) ~= "userdata" then
            b[i] = format(itemstr, tab, k, v)
        end

        i = i + 1
    end

    b[i] = (tab .. "]"):sub(3)

    return concat(b, "\n")
end

return {
    get = get,
    clone = clone,
    equals = equals,
    merge = merge,
    tostring = tostring
}

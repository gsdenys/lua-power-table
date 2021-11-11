local format = string.format
local concat = string.concat

local TABLE_NAME = "ptable"


local function get(tbl, key)
    local value = tbl[key]

    if value == nil then return nil end

    if type(value) == "table" then
        local t = require(TABLE_NAME)
        return t(value)
    end

    return value
end

local function clone(tbl)
    local copy = require(TABLE_NAME)({})

    for k, v in pairs(tbl) do
        if type(v) == "table" then
            v = clone(v)
        end

        copy:insert(k,v)
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

return {get = get, clone = clone, tostring = tostring}

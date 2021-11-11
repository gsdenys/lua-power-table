local TABLE_NAME = "ptable"

local function get_keys(t)
    local keyset = {}
    local index = 1

    for key, _ in pairs(t) do
        keyset[index] = key
        index = index + 1
    end

    return keyset
end

local function get_values(t)
    local valueset = {}
    local index = 1

    for _, value in pairs(t) do
        if type(value) == 'table' then
            value = require(TABLE_NAME)(value)
        end

        valueset[index] = value
        index = index + 1
    end

    return valueset
end

return {keys = get_keys, values = get_values}
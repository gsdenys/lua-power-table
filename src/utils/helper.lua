local types = require "ptable.utils.types"

local helper = {}

-- Parameter to be used in the reflection and make reference to the obtention of
-- function name.
local PARAMETER_NAME = "n"

-- Parameter to be used in the reflection and make reference to the obtention of
-- thread stack.
local STACK_NUMBER = 2

---Create a new table adding the functions passed by paramenter to the
-- created table
---@param mt any
---@return any
function helper.new_table(mt, ...)
    -- creates an enhanched table
    local t = {...}

    -- the table must created from an old one in case of a table
    -- just have another one iside
    if #t == 1 and type(t[1]) == types.TABLE then t = t[1] end

    return setmetatable(t, mt)
end

function helper.function_name()
    return debug.getinfo(STACK_NUMBER, PARAMETER_NAME).name
end

return helper

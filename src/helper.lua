
local helper = {}

function helper.new_table(mt, ...)
    -- creates an enhanched table
    local t = {...}

    if #t == 1 and type(t[1]) == "table" then
        -- the table is created from an old one
        t = t[1]
    end

    return setmetatable(t, mt)
end


return helper
local assertion = require "ptable.assertion"

local FUNCTION_NAME = "iterator"

local iterator = {}

function iterator:Key()
    if #self.keys > 0 then return self.keys[self.it] end

    return self.it
end

function iterator:value() return self.t[self:Key()] end

function iterator:HasNext()
    if #self.keys > 0 then return self.it < #self.keys end
    return self.it < #self.t
end

function iterator:Next()
    self.it = self.it + 1
    return self.t[self:Key()]
end

return function(t)
    assertion.Table(t, FUNCTION_NAME)

    local it = iterator

    it.t = t
    it.keys = t:keys()
    it.it = 0

    return it
end



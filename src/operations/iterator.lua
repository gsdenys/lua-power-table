---
--- @module iterator
--- @author Denys G. Santos
--- @copyright 2021-2022
--- @license MIT
--- @release 1.0.0
---

local assertion = require "ptable.assertion"
local messages = require "ptable.utils.messages"

local iterator = {}

---Return the actual key. Before first  and after the last iteration
---the result of this method will be nil
---@return any - the actual key
function iterator:key()
    if self.it == 0 then return nil end

    if self.it > #self.keys then return nil end

    if #self.keys > 0 then return self.keys[self.it] end

    return self.it
end

---Return the actual value. Before first  and after the last iteration
---the result of this method will be nil.
---@return any - the actual key
function iterator:value()
    local key = self:key()

    if key == nil then return nil end

    return self.t[self:key()]
end

--- verify if the iterator has next element
---@return boolean - true if has next, other else false
function iterator:hasNext()
    if #self.keys > 0 then return self.it < #self.keys end
    return false
end

---iterate to the next element. in case of iterate more then the numbers
---of elements you'll receive an array index out of bound exception
function iterator:next()
    assertion.True("iterator.next", messages.ARRAY_INDEX_OUT_OF_BOUND,
                   #self.keys > self.it)

    self.it = self.it + 1
end

---Factory to create the iterator
---@param t any theorder table
---@return table - the iterator
return function(t)
    local FUNCTION_NAME = debug.getinfo(1, "n").name
    assertion.Table(t, FUNCTION_NAME)

    local iter = iterator

    iter.t = t
    iter.keys = t:keys()
    iter.it = 0

    return iter
end


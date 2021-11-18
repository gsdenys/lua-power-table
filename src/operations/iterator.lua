--- This module is an iterator that knows how to access items from the table, one at a time,
--- keeping track of the current position in a given sequence.
---
--- @module iterator
--- @author Denys G. Santos
--- @copyright 2021-2022
--- @license MIT
--- @release 1.0.0

local iterator = {}

-- add the assertion module to do not allow not permited execution. Sometimes it can
-- generate an output error.
local assertion = require "ptable.assertion"

-- add messages module to use together assert to output the correct error message
local messages = require "ptable.utils.messages"

---Obtain the key for the actual iteration. Before first and after the last iteration
---the result will be every nil.
---
--- @usage
---   local table = require "ptable"
---   local tbl   = table({a = 1, b = 2, c = 3})
---   local it    = tbl:iterator()
---
---   it:next() -- the first iteration to point counter to the first pairs element
---   it:key()  -- it'll return 'a'
---
---@return any - the actual key
function iterator:key()
    -- return nill before the first itertion
    if self.it == 0 then return nil end

    -- return nil after the last iteration
    if self.it > #self.keys then return nil end

    -- case the table has keys (key - value) return the key.
    if #self.keys > 0 then return self.keys[self.it] end

    -- return the key. in this case this is not performed over the key - value table and
    -- we'll get the count of iteration that results in the array position where the data
    -- is storage
    return self.it
end

---Obtain the value for the actual iteration. Before first and after the last iteration
---the result will be every nil.
---
--- @usage
---   local table = require "ptable"
---   local tbl   = table({a = 1, b = 2, c = 3})
---   local it    = tbl:iterator()
---
---   it:next() -- the first iteration to point counter to the first pairs element
---   it:value()  -- it'll return '1'
---
---@return any - the actual key
function iterator:value()
    -- get the actual key
    local key = self:key()

    -- in case of before first call and after last return nill
    if key == nil then return nil end

    -- returns the value of the actual iterator
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

function iterator:remove()
    
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


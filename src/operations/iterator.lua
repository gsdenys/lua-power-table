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

-- add helper module to possibilitate to get the executed function name
local helper = require "ptable.utils.helper"

---Obtain the key for the actual iteration. Before first and after the last iteration
---the result will be every nil.
---
--- @usage
---   local table = require "ptable"
---   local tbl   = table({a = 1, b = 2, c = 3})
---   local it    = tbl:iterator()
---
---   it:next() -- perform iteration to point counter to the first pairs element
---   it:key()  -- it'll return 'a'
---
---@return any - the actual key
function iterator:key()
    -- return nill before the first itertion
    if self.iteration == 0 then return nil end

    -- return nil after the last iteration
    if self.iteration > #self.keys then return nil end

    -- case the table has keys (key - value) return the key.
    if #self.keys > 0 then return self.keys[self.iteration] end

    -- return the key. in this case this is not performed over the key - value table and
    -- we'll get the count of iteration that results in the array position where the data
    -- is storage
    return self.iteration
end

---Obtain the value for the actual iteration. Before first and after the last iteration
---the result will be every nil.
---
--- @usage
---   local table = require "ptable"
---   local tbl   = table({a = 1, b = 2, c = 3})
---   local it    = tbl:iterator()
---
---   it:next()  -- perform iteration to point counter to the first pairs element
---   it:value() -- it'll return '1'
---
---@return any - the actual key
function iterator:value()
    -- get the actual key
    local key = self:key()

    -- in case of before first call and after last return nill
    if key == nil then return nil end

    -- returns the value of the actual iterator
    return self.t[key]
end

--- Check if the iterator has the next element.
---
--- @usage
---   local table = require "ptable"
---   local tbl   = table({a = 1, b = 2, c = 3})
---   local it    = tbl:iterator()
---
---   it:hasnext() -- it'll return true
---
---@return boolean - true if has next, other else false
function iterator:hasNext()
    if #self.keys > 0 then return self.iteration < #self.keys end
    return false
end

---iterate to the next element. in case of iterate more then the numbers
---of elements you'll receive an array index out of bound exception
function iterator:next()
    assertion.True(helper.function_name(), messages.ARRAY_INDEX_OUT_OF_BOUND,
                   #self.keys > self.iteration)

    self.iteration = self.iteration + 1

    return self:key(), self:value()
end

---Factory to create the iterator
---@param t any theorder table
---@return table - the iterator
return function(t)
    assertion.Table(t, helper.function_name())

    local iter = iterator

    iter.t = t
    iter.keys = t:keys()
    iter.iteration = 0

    return iter
end


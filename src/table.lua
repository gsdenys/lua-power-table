local table = table

local helper = require "ptable.utils.helper"

local keyvalue = require "ptable.operations.kv"
local basic    = require "ptable.operations.basic"
local iterator = require "ptable.operations.iterator"
local nothing  = require "ptable.operations.nothing"

local mt = {__index = table}

function table:void() return nothing.void() end

function table:info() return nothing.info() end

function table:get(key) return basic.get(self, key) end

function table:clone() return basic.clone(self) end

function table:merge(t, overwrite) return basic.merge(self, t, overwrite) end

function table:equals(t) return basic.equals(self, t) end

function table:size() return basic.size(self) end

function table:tostring() return basic.tostring(self) end

function table:keys() return keyvalue.keys(self) end

function table:values() return keyvalue.values(self) end

function table:iterator() return iterator(self) end

return setmetatable(table, {
    __call = function(t, ...) return helper.new_table(mt, ...) end
})

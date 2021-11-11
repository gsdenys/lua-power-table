local table = table

local helper = require "ptable.helper"

local kv = require "ptable.operations.kv"
local basic = require "ptable.operations.basic"

local mt = {__index = table}

function table:get(key) return basic.get(self, key) end

function table:clone() return basic.clone(self) end

function table:merge(t, overwrite) return basic.merge(self, t, overwrite) end

function table:equals(t) return basic.equals(self, t) end

function table:tostring() return basic.tostring(self) end

function table:keys() return kv.keys(self) end

function table:values() return kv.values(self) end

return setmetatable(table, {
    __call = function(t, ...) return helper.new_table(mt, ...) end
})

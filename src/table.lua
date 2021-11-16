--- This module provides powerfull methods to lua table injecting it inside that table, it's objective is
--- to make easier to do basics operation over table instantied object.
---
--- The development of this module comes for the purpose of facilitate the programmer life giving then a
--- way to write a code not replicating the same functions for every project that they do.
---
--- With this module programmer can have their code prettier and focused in whats really metters, that is
--- the creative actions, and not thinking about the basics actions like get the tables size or merge 2
--- others.
---
--- @module Power-Table
--- @author Denys G. Santos <gsdenys@gmail.com>
--- @license MIT
--- @release 1.0.0
local table = table

local helper = require "ptable.utils.helper"

local keyvalue = require "ptable.operations.kv"
local basic = require "ptable.operations.basic"
local iterator = require "ptable.operations.iterator"
local nothing = require "ptable.operations.nothing"
local each = require "ptable.operations.each"

local mt = {__index = table}

--- A void method that you can use to check it your table has this extention.
---
--- @usage
---   local table = require "ptable"
---   local tbl = table({})
---   tbl.void() --it'll do nothing
function table:void() nothing.void() end

--- Provides some informations about this library.
---
--- @usage
---   local table = require "ptable"
---   local tbl = table({})
---   tbl.info() --it'll return the information in string format
---
---@return string - the library informations
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

function table:each(fn, ...) return each.each(self, fn, ...) end

function table:eachk(fn, ...) return each.eachk(self, fn, ...) end

function table:eachi(fn, ...) return each.eachi(self, fn, ...) end

return setmetatable(table, {
    __call = function(t, ...) return helper.new_table(mt, ...) end
})

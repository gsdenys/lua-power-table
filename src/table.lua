--- This module provides powerfull methods to lua table injecting it inside that table,
--- it's objective is to make easier to do basics operation over table instantied object.
---
--- The development of this module comes for the purpose of facilitate the programmer life
--- giving then a way to write a code not replicating the same functions for every project
--- that they do.
---
--- With this module programmer can have their code prettier and focused in whats really
--- metters, that is the creative actions, and not thinking about the basics actions like
--- get the tables size or merge 2 others.
---
--- @module table
--- @author Denys G. Santos
--- @copyright 2021-2022
--- @license MIT
--- @release 1.0.0
local table = table

-- Add the module that provides methos to add the table inprovements through
-- the setmetatable.
local helper = require "ptable.utils.helper"

-- Add the key/values module that provides all methods associated with obtention
-- of keys or values
local keyvalue = require "ptable.operations.kv"

-- Add the basic module that contains all operation considered basic like clone
-- merge, size, equals, and so on.
local basic = require "ptable.operations.basic"

-- Add iterator module to provides the possibility to iterate  over the table data
-- or theirs key or values.
local iterator = require "ptable.operations.iterator"

-- Add the module to enable access to the void and info methods.
local nothing = require "ptable.operations.nothing"

-- Add the each module that contains all methods to perform a given function over
-- all table pairs, keys or values.
local each = require "ptable.operations.each"

-- metatable origin
local mt = {__index = table}

--- A void method that you can use to check it your table has this extention.
---
--- @usage
---   local table = require "ptable"
---   local tbl = table({})
---   tbl.void() --it'll do nothing
function table.void() nothing.void() end

--- Provides some informations about this library.
---
--- @usage
---   local table = require "ptable"
---   local tbl = table({})
---   tbl.info() --it'll return the information in string format
---
--- @return string - the library informations
function table.info() return nothing.info() end

--- Get element based on a given key. The value returne always is a
--- table element or nil (in case of key is not present in the table).
---
--- @usage
---   local table = require "ptable"
---   local tbl = table({a = 1, b = 2, c = 3})
---   local value = tbl:get(a) -- it should return 1
---
--- @param key any - some key
--- @return any - the value stored or nil
function table:get(key) return basic.get(self, key) end

---Create a deep copy of this table.
---
--- @usage
---   local table = require "ptable"
---   local tbl = table({a = 1, b = 2, c = 3})
---   local clone = tbl:clone() -- it should return a new table equals the tbl
---
---@return table - the new created table
function table:clone() return basic.clone(self) end

--- Merge this table with another one. There are two types of merging, the first one,
--- that is the default option, overwrite the intersecting elements (replace the
--- first one by the second), and the second their maintains (ignores the second's
--- intersection values).
---
--- It's important to know that this method doesn't return another table. Different of
--- clone method, this one just actualize this active instance.
---
--- @usage
---   local table = require "ptable"
---
---   local first_table  = table({a = 1, b = 2, c = 3})
---   local cloned_table = first_table:clone()
---
---   local other_table = table({b = 4, c = 5, d = 6})
---
---   first_table:merge(oth) -- 'first_table' == {a = 1, b = 4, c = 5, d = 6}
---   cloned_table:merge(oth, false) -- 'cloned_table' == {a = 1, b = 2, c = 3, d = 6}
---
--- @param t table - the table to be merged with this one
--- @param overwrite boolean - inform if the data must be overwritten (option - default true)
function table:merge(t, overwrite) basic.merge(self, t, overwrite) end

--- Compare this table with another and return true in case of both are equals,
--- other else return false.
---
--- This function compare unically the key an value of the tables, ignoring
--- completally the overload that both could had received.
---
--- @usage
---   local table = require "ptable"
---   local tbl = table({a = 1, b = 2, c = 3})
---   local oth = table({a = 1, b = 2, c = 3})
---   local equals = tbl:equals(oth) -- it should return true
---
--- @param t table - the table to be compared
--- @return boolean - true if both are equals, other else false
function table:equals(t) return basic.equals(self, t) end

--- Obtain the size of the table. As the lua has no simple way to get the lengh of, this
--- implementation use the count of all pairs inside that.
---
--- This function compare unically the number of pairs inside the tables, ignoring
--- completally the overload that it should have received.
---
--- @usage
---   local table = require "ptable"
---   local tbl = table({a = 1, b = 2, c = 3})
---   local size = tbl:size() -- it must return 3
---
---@return integer - the size of the table
function table:size() return basic.size(self) end

---Returns a printable multiline string that map all pairs stored inse this table
---
--- @usage
---   local table = require "ptable"
---   local tbl = table({a = 1, b = 2, c = 3})
---   local str = tbl:tostring() -- it must return the printable string
---
---@return string - the printable multiline string
function table:tostring() return basic.tostring(self) end

---Obtains the table keyset.
---
--- This function compare unically the data mapped in pairs inside the tables, ignoring
--- completally the overload that it should have received.
---
--- @usage
---   local table = require "ptable"
---   local tbl   = table({a = 1, b = 2, c = 3})
---   local keys  = tbl:keys() -- it must return {a, b, c}
---
---@return table - A table with the keyset
function table:keys() return keyvalue.keys(self) end

--- Obtains the table values list.
---
--- This function compare unically the data mapped in pairs inside the tables, ignoring
--- completally the overload that it should have received.
---
--- @usage
---   local table = require "ptable"
---   local tbl   = table({a = 1, b = 2, c = 3})
---   local keys  = tbl:values() -- it must return {1, 2, 3}
---
---@return table - A table with the values list
function table:values() return keyvalue.values(self) end

--- Execute a given function with the parameter 'key' and 'value' followed by any others your choose.
---
--- @usage
---   local table = require "ptable"
---   local tbl   = table({a = 1, b = 2, c = 3})
---   local keys  = tbl:each(print, "hello")
---   -- it must print:
---   -- a 1 hello
---   -- b 2 hello
---   -- c 3 hello
---
--- @param fn function - the function to be executed over each pears
function table:each(fn, ...) each.each(self, fn, ...) end

--- Execute a given function with the parameter 'key' followed by any others your choose.
---
--- @usage
---   local table = require "ptable"
---   local tbl   = table({a = 1, b = 2, c = 3})
---   local keys  = tbl:eachk(print, "hello")
---   -- it must print:
---   -- a hello
---   -- b hello
---   -- c hello
---
--- @param fn function - the function to be executed over each key
function table:eachk(fn, ...) each.eachk(self, fn, ...) end

--- Execute a given function with the parameter 'value' followed by any others your choose.
---
--- @usage
---   local table = require "ptable"
---   local tbl   = table({a = 1, b = 2, c = 3})
---   local keys  = tbl:eachi(print, "hello")
---   -- it must print:
---   -- 1 hello
---   -- 2 hello
---   -- 3 hello
---
--- @param fn function - the function to be executed over each value
function table:eachi(fn, ...) each.eachi(self, fn, ...) end

--- Get the iterator object from this table
---
--- @usage
---   local table = require "ptable"
---   local tbl   = table({a = 1, b = 2, c = 3})
---   local it    = tbl:iterator()
---
--- @return any - the iterator object
function table:iterator() return iterator(self) end

--- Remove the all elements passed by paramenter to this table
---
--- @usage
---   local table = require "ptable"
---   local tbl   = table({a = 1, b = 2, c = 3})
---   tbl:remove(a, b) -- the table will be {c = 3}
---@diagnostic disable-next-line: undefined-doc-param
--- @param arg any the list of elements to be deleted
function table:del(...) basic.delete_element(self, ...) end

-- use setmetatable function to overload methods to this table
return setmetatable(table, {
    __call = function(t, ...) return helper.new_table(mt, ...) end
})

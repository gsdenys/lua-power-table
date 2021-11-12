local level = require "ptable.utils.level"
local messages = require "ptable.utils.messages"

local format = string.format

---Table that contains all implementation type of warning.
---Basically this table just contains functions
local warning = {}

---sendWarning function that print the message each called time
---@param msg string the warn message
---@param fn string the function name
local function sendWarning(msg, fn)
    local message = messages.MESSAGE_BASE .. msg
    print(format(message, level.WARN, fn))
end

---Nil value warning function that use print to comunitate with user
---@param fn string the function name
---@param value string the warning message
function warning.Nil(fn, value)
    if value == nil then sendWarning(messages.NIL_VALUE, fn) end
end

---Test function that warn when the execution pass in the test
---@param fn string the function name
---@param msg string the warn message
---@param test boolean the test
function warning.Test(fn, msg, test) if test then sendWarning(msg, fn) end end

-- Export assertion table function
return warning

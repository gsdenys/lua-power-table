local types = require "ptable.utils.types"
local level = require "ptable.utils.level"
local messages = require "ptable.utils.messages"

local format = string.format
local type = type

---Table that contains all implementation type of assertion.
---Basically this table just contains functions
local assertion = {}

---The name of table function. I'd opt to not use reflection to make it
---faster.
local TABLE_FUNCTION_NAME = "Table"

---failOnAssert function that throws an exception each called time
---@param msg string the error message
---@param fn string the function name
local function failOnAssert(msg, fn)
    local message = messages.MESSAGE_BASE .. msg
    error(format(message, level.ERROR, fn))
end

---assert_table function to help others function to call table assertion
---@param t table the table that want to try
---@param fn function the function name
local function assert_table(t, fn)
    if type(t) ~= types.TABLE then
        failOnAssert(messages.T_MUST_BE_NOT_NIL_TABLE, fn)
    end
end

---Table assert that throws exception when <t> receiver parameter has the
---type different of 'table'
---@param t table the table that want to ty
---@param fn function the function name
function assertion.Table(t, fn) assert_table(t, fn or TABLE_FUNCTION_NAME) end

---Function assert that throws exception when <t> parameter has the type
---different of 'table' or the <f> parameter has the type different of 'function'
---@param fn string the function name
---@param t table the table that want to try
---@param f function the function that want to try
function assertion.Func(fn, t, f)
    assert_table(t, fn)

    if type(f) ~= types.FUNCTION then
        failOnAssert(messages.REQUIRE_NOT_NIL_FUNCTION, fn)
    end
end

---Number assert that throws exception when <num> parameter has the type different
---of 'number'
---@param fn string the function name
---@param num number the numbert that want to try
function assertion.Number(fn, num)
    if type(num) ~= types.NUMBER then
        failOnAssert(messages.REQUIRE_NUMBER, fn)
    end
end

---True function that throws exception when <test> is false
---@param fn string the function name
---@param msg string the error message
---@param test boolean the test
function assertion.True(fn, msg, test) if not test then failOnAssert(msg, fn) end end

-- Export assertion table function
return assertion

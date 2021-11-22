require "busted.runner"()

local assert = assert

describe("[Iterator]", function()
    local ptable = require "ptable"

    describe("Empty table", function()
        local empty_table = ptable({})
        local i = empty_table:iterator()

        it("should not be nil", function() assert.is_not.Nil(i) end)
        it("should return nil", function() assert.Nil(i:key()) end)
        it("should return nil", function() assert.Nil(i:value()) end)
        it("should return false", function() assert.False(i:hasNext()) end)

    end)

    describe("Not empty table", function()
        local tbl = ptable({a = 1, b = 2})
        local i = tbl:iterator()

        it("should not be nil", function() assert.is_not.Nil(i) end)

        it("should not return nil", function() assert.Nil(i:key()) end)
        it("should not return nil", function() assert.Nil(i:value()) end)
        it("should not return true", function() assert.True(i:hasNext()) end)
    end)

    describe("key value table", function()
        local tbl = ptable({a = 1, b = 2})
        local i = tbl:iterator()

        i:next()
        local key = i:key()
        local value = i:value()

        it("should return 'a' or 'b'",
           function() assert.True("a" == key or "b" == key) end)
        it("should return '1' or '2'",
           function() assert.True(1 == value or 2 == value) end)
        it("should return '1' or '2'", function()
            assert.True(
                (key == "a" and value == 1) or (key == "b" and value == 2))
        end)
        it("should return true", function() assert.True(i:hasNext()) end)
    end)

    describe("key value table", function()
        local tbl = ptable({a = 1, b = 2})
        local i = tbl:iterator()

        local function some_test()
            i:next()
            i:next()
            i:next()
        end

        it("should return error", function()
            local _, err = pcall(some_test)
            assert.is_not.Nil(err)
        end)
    end)

    describe("Numerical table", function()
        local tbl = ptable({1, 2})
        local i = tbl:iterator()

        i:next()
        local key = i:key()
        local value = i:value()

        it("should return '1' or '2'",
           function() assert.True(1 == key or 2 == key) end)
        it("should return '1' or '2'",
           function() assert.True(1 == value or 2 == value) end)
        it("should return true", function() assert.True(i:hasNext()) end)
    end)

    describe("key value table", function()
        local tbl = ptable({1, 2})
        local i = tbl:iterator()

        local function some_test()
            i:next()
            i:next()
            i:next()
        end

        it("should return error", function()
            local _, err = pcall(some_test)
            assert.is_not.Nil(err)
        end)
    end)
end)

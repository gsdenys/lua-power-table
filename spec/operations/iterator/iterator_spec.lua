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

    describe("Numerical table", function()
        local tbl = ptable({a = 1, b = 2})
        local i = tbl:iterator()

        it("should not be nil", function() assert.is_not.Nil(i) end)

        it("should return nil", function() assert.Nil(i:key()) end)
        it("should return nil", function() assert.Nil(i:value()) end)
        it("should return true", function() assert.True(i:hasNext()) end)
    end)

    describe("Numerical table", function()
        local tbl = ptable({a = 1, b = 2})
        local i = tbl:iterator()

        it("should not be nil", function() assert.is_not.Nil(i) end)

        i:next()
        it("should return 0", function() assert.equal("a", i:key()) end)
        it("should return nil", function() assert.equal(1, i:value()) end)
        it("should return true", function() assert.True(i:hasNext()) end)
    end)

    describe("Numerical table", function()
        local tbl = ptable({a = 1, b = 2})
        local i = tbl:iterator()

        it("should not be nil", function() assert.is_not.Nil(i) end)

        i:next()
        i:next()
        it("should return 0", function() assert.equal("b", i:key()) end)
        it("should return nil", function() assert.equal(2, i:value()) end)
        it("should return true", function() assert.False(i:hasNext()) end)
    end)

    describe("Numerical table", function()
        local tbl = ptable({a = 1, b = 2})
        local i = tbl:iterator()

        it("should not be nil", function() assert.is_not.Nil(i) end)

        local function some_test()
            i:next()
            i:next()
            i:next()
        end

        local _, err = pcall(some_test)
        assert.is_not.Nil(err)
    end)
end)

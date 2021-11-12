require "busted.runner"()

local assert = assert

describe("[Iterator]", function()
    local ptable = require "ptable"

    describe("Empty table", function()
        local empty_table = ptable({})
        local iter = empty_table:iterator()

        it("should return nil value", function() assert.False(iter:HasNext()) end)
    end)

    describe("Key", function()
        local kv = ptable({a = 1, b = 2, c = 3})
        local nm = ptable({1, 2, 3})

        it("should have nil value", function()
            local i = nm:iterator()

            assert.Nil(i:Key())
        end)

        it("should have nil value", function()
            local i = kv:iterator(nm)

            assert.Nil(i:Key())
        end)
    end)
end)

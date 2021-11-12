require "busted.runner"()

describe("[Size]", function()
    local table = require "ptable"

    describe("Empty table", function()
        local empty_table = table({})
        local value = empty_table:size()

        it("should return 0", function() assert.equal(0, value) end)
    end)

    describe("Numeric table with pairs", function()
        local table_with_pairs = table({a = 1, b = 2, c = 3})

        local value = table_with_pairs:size()

        it("should not return nil value",
           function() assert.is_not.Nil(value) end)

        it("should return 3",
           function() assert.equal(3, value) end)
    end)

    describe("Numeric table with pairs", function()
        local table_with_pairs = table({a = "one", b = "two", c = "three"})

        local value = table_with_pairs:size()

        it("should not return nil value",
           function() assert.is_not.Nil(value) end)

        it("should return 3",
           function() assert.equal(3, value) end)
    end)


    describe("Numeric table with pairs with table", function()
        local table_with_pairs = table({a = {a = 1}, b = 2, c = {c = {c = 3}}})

        local value = table_with_pairs:size()

        it("should not return nil value",
           function() assert.is_not.Nil(value) end)

        it("should return 3",
           function() assert.equal(3, value) end)
    end)
end)

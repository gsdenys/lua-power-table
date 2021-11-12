require "busted.runner"()

describe("[Clone]", function()
    local table = require "ptable"

    describe("Empty table", function()
        local empty_table = table({})
        local other_empty_table = empty_table:clone()

        local resp = empty_table:equals(other_empty_table)
        it("should return true", function() assert.True(resp) end)
    end)

    describe("Numeric table with pairs", function()
        local table_with_pairs = table({a = 1, b = 2, c = 3})
        local other_table_with_pairs = table_with_pairs:clone()

        local resp = table_with_pairs:equals(other_table_with_pairs)
        it("should return true", function() assert.True(resp) end)
    end)

    describe("String table with pairs", function()
        local table_with_pairs = table({a = "one", b = "two", c = "three"})
        local other_table_with_pairs = table_with_pairs:clone()

        local resp = table_with_pairs:equals(other_table_with_pairs)
        it("should return true", function() assert.True(resp) end)
    end)

    describe("Table with pairs with tables", function()
        local table_with_pairs = table({a = {a = 1}, b = 2, c = {c = {c = 3}}})
        local other_table_with_pairs = table_with_pairs:clone()

        local resp = table_with_pairs:equals(other_table_with_pairs)
        it("should return true", function() assert.True(resp) end)
    end)
end)

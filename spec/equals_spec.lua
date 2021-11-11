require "busted.runner"()

describe("[Equals]", function()
    local table = require "ptable"

    describe("Empty table", function()
        local empty_table = table({})
        local other_empty_table = table({})

        local resp = empty_table:equals(other_empty_table)
        it("should return true", function() assert.True(resp) end)

        empty_table:insert(1)
        local resp2 = empty_table:equals(other_empty_table)
        it("should return false", function() assert.False(resp2) end)

        other_empty_table:insert(1)
        local resp3 = empty_table:equals(other_empty_table)
        it("should return true", function() assert.True(resp3) end)
    end)

    describe("Numeric table with pairs", function()
        local table_with_pairs = table({a = 1, b = 2, c = 3})
        local other_table_with_pairs = table({a = 1, b = 2, c = 3})

        local resp = table_with_pairs:equals(other_table_with_pairs)
        it("should return true", function() assert.True(resp) end)

        other_table_with_pairs["d"] = 4
        local resp2 = table_with_pairs:equals(other_table_with_pairs)
        it("should return false", function() assert.False(resp2) end)

    end)

    describe("String table with pairs", function()
        local table_with_pairs = table({a = "one", b = "two", c = "three"})
        local other_table_with_pairs = table({a = "one", b = "two", c = "three"})

        local resp = table_with_pairs:equals(other_table_with_pairs)
        it("should return true", function() assert.True(resp) end)

        other_table_with_pairs["d"] = "four"
        local resp2 = table_with_pairs:equals(other_table_with_pairs)
        it("should return false", function() assert.False(resp2) end)
    end)



    describe("Table with pairs with tables", function()
        local table_with_pairs = table({a = {a = 1}, b = 2, c = {c = {c = 3}}})
        local other_table_with_pairs = table({a = {a = 1}, b = 2, c = {c = {c = 3}}})

        local resp = table_with_pairs:equals(other_table_with_pairs)
        it("should return true", function() assert.True(resp) end)

        other_table_with_pairs["c"]["c"]["d"] = "four"
        local resp2 = table_with_pairs:equals(other_table_with_pairs)
        it("should return false", function() assert.False(resp2) end)
    end)
end)

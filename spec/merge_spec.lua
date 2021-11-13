require "busted.runner"()

describe("[Clone]", function()
    local table = require "ptable"

    describe("Two empties table", function()
        local empty_table = table({})
        local other_empty_table = table({})

        empty_table:merge(other_empty_table)

        local resp = empty_table:equals(table({}))
        it("should return true", function() assert.True(resp) end)
    end)

    describe("One empty table", function()
        local empty_table = table({})
        local other_empty_table = table({1, 2, 3})

        empty_table:merge(other_empty_table)

        local resp = empty_table:equals(table({}))
        it("should return false", function() assert.False(resp) end)

        local value = empty_table:size()
        it("should has 3 elements", function() assert.equal(3, value) end)
    end)

    describe("Numeric table with pairs", function()
        local tbl = table({a = 1, b = 2, c = 3})
        local other_tbl = table({4, 5, 6})

        tbl:merge(other_tbl)

        local resp = tbl:equals(table({}))
        it("should return false", function() assert.False(resp) end)

        local value = tbl:size()
        it("should has 6 elements", function() assert.equal(6, value) end)
    end)


    describe("Numeric table with pairs", function()
        local tbl = table({a = 1, b = 2, c = 3})
        local cln = tbl:clone()
        local oth = table({d = 4, e = 5, f = 6})

        tbl:merge(oth)

        local resp = tbl:equals(cln)
        it("should return false", function() assert.False(resp) end)

        local size = tbl:size()
        it("should has 6 elements", function() assert.equal(6, size) end)

        local value = tbl:get("f")
        it("should return 6", function() assert.equal(6, value) end)
    end)

    describe("Numeric table with pairs default overwrited", function()
        local tbl = table({a = 1, b = 2, c = 3})
        local cln = tbl:clone()
        local oth = table({b = 4, c = 5, d = 6})

        tbl:merge(oth)

        local resp = tbl:equals(cln)
        it("should return false", function() assert.False(resp) end)

        local size = tbl:size()
        it("should has 4 elements", function() assert.equal(4, size) end)

        local value1 = tbl:get("b")
        it("should return 4", function() assert.equal(4, value1) end)

        local value2 = tbl:get("c")
        it("should return 5", function() assert.equal(5, value2) end)
    end)

    describe("Numeric table with pairs force overwrite", function()
        local tbl = table({a = 1, b = 2, c = 3})
        local cln = tbl:clone()
        local oth = table({b = 4, c = 5, d = 6})

        tbl:merge(oth, true)

        local resp = tbl:equals(cln)
        it("should return false", function() assert.False(resp) end)

        local size = tbl:size()
        it("should has 4 elements", function() assert.equal(4, size) end)

        local value1 = tbl:get("b")
        it("should return 4", function() assert.equal(4, value1) end)

        local value2 = tbl:get("c")
        it("should return 5", function() assert.equal(5, value2) end)
    end)

    describe("Numeric table with pairs no overwrite", function()
        local tbl = table({a = 1, b = 2, c = 3})
        local cln = tbl:clone()
        local oth = table({b = 4, c = 5, d = 6})

        tbl:merge(oth, false)

        local resp = tbl:equals(cln)
        it("should return false", function() assert.False(resp) end)

        local size = tbl:size()
        it("should has 4 elements", function() assert.equal(4, size) end)

        local value1 = tbl:get("b")
        it("should return 2", function() assert.equal(2, value1) end)

        local value2 = tbl:get("c")
        it("should return 3", function() assert.equal(3, value2) end)
    end)
end)

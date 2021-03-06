require "busted.runner"()

describe("[Get]", function()
    local table = require "ptable"

    describe("Empty table", function()
        local empty_table = table({})
        local value = empty_table:get("somme-key")

        it("should return nil value", function() assert.Nil(value) end)
    end)

    describe("Numeric table with pairs", function()
        local table_with_pairs = table({a = 1, b = 2, c = 3})
        local key = "a"
        local rvalue = 1

        local value = table_with_pairs:get(key)

        it("should not return nil value for" .. key,
           function() assert.is_not.Nil(value) end)

        it("should return a number",
           function() assert.equal(type(value), "number") end)

        it("should return " .. rvalue, function() assert.equal(1, value) end)
    end)

    describe("String table with pairs", function()
        local table_with_pairs = table({a = "one", b = "two", c = "three"})
        local key = "a"
        local rvalue = "one"

        local value = table_with_pairs:get(key)

        it("should not return nil value",
           function() assert.is_not.Nil(value) end)

        it("should return a number",
           function() assert.equal(type(value), "string") end)

        it("should return " .. rvalue, function()
            assert.equal("one", value)
        end)
    end)

    describe("Table with pairs with tables", function()
        local table_with_pairs = table({a = {a = 1}, b = 2, c = {c = {c = 3}}})

        local value = table_with_pairs:get("c")

        it("should not return nil value",
           function() assert.is_not.Nil(value) end)

        it("should be a table",
           function() assert.equal(type(value), "table") end)

        local value2 = value:get("c")

        it("should not have nil value", function()
            assert.is_not.Nil(value2)
        end)

        it("should be a table",
           function() assert.equal(type(value2), "table") end)

        local value3 = value2:get("c")

        it("should not have nil value", function()
            assert.is_not.Nil(value3)
        end)

        it("should be a number",
           function() assert.equal(type(value3), "number") end)

        it("should have value equal 3", function()
            assert.equal(3, value3)
        end)
    end)
end)

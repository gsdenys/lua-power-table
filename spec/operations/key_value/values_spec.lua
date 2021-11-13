require "busted.runner"()

local function equals(keys, compare)
    if #keys ~= #compare then return false end

    local count = 0

    for i = 1, #keys do
        for j = 1, #compare do
            if keys[i] == compare[j] then
                count = count + 1
                break
            end
        end
    end

    return count == #keys
end

describe("[values]", function()
    local table = require "ptable"

    describe("empty table", function()
        local empty_table = table({})
        local values = empty_table:values()

        it("should not have nil values", function() assert.is_not.Nil(values) end)

        it("should have size equals 0", function() assert.equal(0, #values) end)

        it("should have the values {}",
           function() assert.True(equals(values, {})) end)
    end)


    describe("table with pairs", function()
        local table_with_pairs = table({a = 1, b = 2, c = 3})
        local values = table_with_pairs:values()

        it("should not have nil values", function() assert.is_not.Nil(values) end)

        it("should have size equals 3", function() assert.equal(3, #values) end)

        it("should have the values {1, 2, 3}",
           function() assert.True(equals(values, {1, 2, 3})) end)
    end)

    describe("table with numbers", function()
        local table_with_numbers = table({1, 2, 3})
        local values = table_with_numbers:values()

        it("should not have nil values", function() assert.is_not.Nil(values) end)

        it("should have size equals 3", function() assert.equal(3, #values) end)

        it("should have the values {1, 2, 1}",
           function() assert.True(equals(values, {1, 2, 3})) end)
    end)

    describe("table with word", function()
        local table_with_words = table({"one", "two", "three"})
        local values = table_with_words:values()

        it("should not have nil values", function() assert.is_not.Nil(values) end)

        it("should have size equals 3", function() assert.equal(3, #values) end)

        it("should have the values {1, 2, 1}",
           function() assert.True(equals(values, {"one", "two", "three"})) end)
    end)
end)

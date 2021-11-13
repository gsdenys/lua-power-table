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

describe("[keys]", function()
    local table = require "ptable"

    describe("empty table", function()
        local empty_table = table({})
        local keys = empty_table:keys()

        it("should not have nil keys", function() assert.is_not.Nil(keys) end)

        it("should have size equals 0", function() assert.equal(0, #keys) end)

        it("should have the keys {}",
           function() assert.True(equals(keys, {})) end)
    end)

    describe("table with pairs", function()
        local table_with_pairs = table({a = 1, b = 2, c = 3})
        local keys = table_with_pairs:keys()

        it("should not have nil keys", function() assert.is_not.Nil(keys) end)

        it("should have size equals 3", function() assert.equal(3, #keys) end)

        it("should have the keys {a, b, c}",
           function() assert.True(equals(keys, {"a", "b", "c"})) end)
    end)

    describe("table with numbers", function()
        local table_with_numbers = table({1, 2, 3})
        local keys = table_with_numbers:keys()

        it("should not have nil keys", function() assert.is_not.Nil(keys) end)

        it("should have size equals 3", function() assert.equal(3, #keys) end)

        it("should have the keys {1, 2, 1}",
           function() assert.True(equals(keys, {1, 2, 3})) end)
    end)

    describe("table with word", function()
        local table_with_words = table({"one", "two", "three"})
        local keys = table_with_words:keys()

        it("should not have nil keys", function() assert.is_not.Nil(keys) end)

        it("should have size equals 3", function() assert.equal(3, #keys) end)

        it("should have the keys {1, 2, 1}",
           function() assert.True(equals(keys, {1, 2, 3})) end)
    end)
end)

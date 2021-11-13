require "busted.runner"()

describe("[tostring]", function()
    local table = require "ptable"

    describe("empty table", function()
        local empty_table = table({})
        local response = "table [\n]"

        local str = empty_table:tostring()

        it("should not be nil", function() assert.is_not.Nil(str) end)

        it("should not be empty", function() assert.is_not.equal(#str, 0) end)

        it("should be " .. response, function()
            assert.equal(response, str)
        end)
    end)

    describe("table with pairs", function()
        local table_with_pairs = table({a = 1, b = 2, c = 3})
        local response =
            "table [\n  key: a, value: 1\n  key: c, value: 3\n  key: b, value: 2\n]"

        local str = table_with_pairs:tostring()

        it("should not be nil", function() assert.is_not.Nil(str) end)

        it("should not be empty", function() assert.is_not.equal(#str, 0) end)

        it("should be " .. response, function()
            assert.equal(response, str)
        end)
    end)

    describe("table with numbers", function()
        local table_with_numbers = table({1, 2, 3})
        local response =
            "table [\n  key: 1, value: 1\n  key: 2, value: 2\n  key: 3, value: 3\n]"

        local str = table_with_numbers:tostring()

        it("should not be nil", function() assert.is_not.Nil(str) end)

        it("should not be empty", function() assert.is_not.equal(#str, 0) end)

        it("should be " .. response, function()
            assert.equal(response, str)
        end)
    end)

    describe("table with numbers", function()
        local table_with_numbers =
            table({a = {a = 1}, b = 2, c = {c = {c = 3}}})
        local response =
            "table [\n  key: a, value: table [\n    key: a, value: 1\n  ]\n  key: c, value: table [\n    key: c, value: table [\n      key: c, value: 3\n    ]\n  ]\n  key: b, value: 2\n]"

        local str = table_with_numbers:tostring()

        it("should not be nil", function() assert.is_not.Nil(str) end)

        it("should not be empty", function() assert.is_not.equal(#str, 0) end)

        it("should be " .. response, function()
            assert.equal(response, str)
        end)
    end)

    describe("table with word", function()
        local table_with_words = table({"one", "two", "three"})
        local response =
            "table [\n  key: 1, value: one\n  key: 2, value: two\n  key: 3, value: three\n]"

        local str = table_with_words:tostring()

        it("should not be nil", function() assert.is_not.Nil(str) end)

        it("should not be empty", function() assert.is_not.equal(#str, 0) end)

        it("should be " .. response, function()
            assert.equal(response, str)
        end)
    end)
end)

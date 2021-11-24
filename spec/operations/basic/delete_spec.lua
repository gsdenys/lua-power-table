require "busted.runner"()

describe("[Delete]", function()
    local table = require "ptable"

    describe("In an Empty table try delete with empty list", function()
        local function some_test()
            local empty_table = table({})
            empty_table:del()
        end

        local _, err = pcall(some_test)
        it("should not return error", function() assert.Nil(err) end)

    end)

    describe("In an Empty table try delete with not empty list", function()
        local function some_test()
            local empty_table = table({})
            empty_table:del(1)
        end

        local _, err = pcall(some_test)
        it("should return not error", function() assert.Nil(err) end)
    end)

    describe("In a simple table, when try delete no element", function()
        local tbl = table({1, 2})
        local function some_test(tbl) tbl:del() end

        local _, err = pcall(some_test, tbl)
        it("should not return error", function() assert.Nil(err) end)

        it("the size of the table should be 2",
           function() assert.equals(2, tbl:size()) end)
    end)

    describe("In a simple table when try delete first element,", function()
        local tbl = table({4, 5, 6})

        tbl:del(1)

        it("the size of the table should be 2",
           function() assert.equals(2, tbl:size()) end)
    end)

    describe("In a simple table, when try delete 2 element,", function()
        local tbl = table({4, 5, 6})
        tbl:del(1, 2)

        it("the size should of the table should be 1",
           function() assert.equals(1, tbl:size()) end)
    end)

    describe("In a simple table, when try delete element out of array,", function()
        local tbl = table({4, 5, 6})
        tbl:del(4)

        it("the size should of the table should be 1",
           function() assert.equals(3, tbl:size()) end)
    end)

    describe("In a key value table, when try to delete no elements", function()
        local tbl = table({a = 4, b = 5, c = 6})
        tbl:del()

        it("the size of the table should be 3",
           function() assert.equals(3, tbl:size()) end)

        it("the value of element 'b' should be 5",
           function() assert.equals(5, tbl["b"]) end)

        it("the value of element 'a' should be 4",
           function() assert.equals(4, tbl["a"]) end)

        it("the value of element 'c' should be 6",
           function() assert.equals(6, tbl["c"]) end)
    end)

    describe("In a key value table, when try to delete 1 elements", function()
        local tbl = table({a = 4, b = 5, c = 6})
        tbl.del(tbl, "c")

        it("the size of the table should be 2",
           function() assert.equals(2, tbl:size()) end)

        it("the value of element 'b' should be 5",
           function() assert.equals(5, tbl["b"]) end)
    end)

    describe("In a key value table, when try to delete 2 elements", function()
        local tbl = table({a = 4, b = 5, c = 6})
        tbl.del(tbl, "a", "c")

        it("the size of the table should be 1",
           function() assert.equals(1, tbl:size()) end)

        it("the last element should be 5",
           function() assert.equals(5, tbl["b"]) end)
    end)

    describe("In a key value table, when try to delete no existent element",
             function()
        local tbl = table({a = 4, b = 5, c = 6})
        tbl:del("e")

        it("the size of the table should be 1",
           function() assert.equals(3, tbl:size()) end)

        it("the value of element 'b' should be 5",
           function() assert.equals(5, tbl["b"]) end)

        it("the value of element 'a' should be 4",
           function() assert.equals(4, tbl["a"]) end)

        it("the value of element 'c' should be 6",
           function() assert.equals(6, tbl["c"]) end)
    end)
end)

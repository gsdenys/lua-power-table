require "busted.runner"()

describe("[Eachi]", function()
    local table = require "ptable"
    _G.print = function() end
    local function some_test(v) print(v) end

    describe("Empty table", function()
        spy.on(_G, "print")

        local empty_table = table({})
        empty_table:eachi(some_test)

        it("should be called",
           function() assert.spy(_G.print).was_not.called() end)
    end)

    describe("Numerical table", function()
        spy.on(_G, "print")

        local empty_table = table({1, 2, 3})
        empty_table:eachi(some_test)

        it("should be called", function()
            assert.spy(_G.print).was.called(3)
        end)
    end)

    describe("Numerical table with one item", function()
        spy.on(_G, "print")

        local empty_table = table({3})
        empty_table:eachi(some_test)

        it("should be called", function()
            assert.spy(_G.print).was.called(1)
        end)

        it("should be called with 3", function()
            assert.spy(_G.print).was.called_with(3)
        end)
    end)

end)

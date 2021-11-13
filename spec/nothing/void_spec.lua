require "busted.runner"()

describe("[Void]", function()
    local table = require "ptable"

    describe("method void with self", function()
        local tab = table({})

        spy.on(table, "void")

        tab:void()
        it("should be called",
           function() assert.spy(table.void).was.called() end)
    end)

    describe("method void", function()
        local tab = table({})

        spy.on(table, "void")

        tab.void()
        it("should be called",
           function() assert.spy(table.void).was.called() end)
    end)
end)

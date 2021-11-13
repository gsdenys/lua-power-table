require "busted.runner"()

describe("[Void]", function()
    local table = require "ptable"

    describe("method info with self", function()
        _G.print = function() end
        local tab = table({})

        spy.on(table, "info")
        spy.on(_G, "print")

        tab:info()
        it("info should be called",
           function() assert.spy(table.info).was.called() end)
        it("print should be called",
           function() assert.spy(_G.print).was.called() end)
    end)

    describe("method info", function()
        _G.print = function() end
        local tab = table({})

        spy.on(table, "info")
        spy.on(_G, "print")

        tab.info()
        it("info should be called",
           function() assert.spy(table.info).was.called() end)
        it("print should be called",
           function() assert.spy(_G.print).was.called() end)
    end)
end)

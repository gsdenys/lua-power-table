require "busted.runner"()

describe("Warnning", function()
    _G.print = function() end

    describe("Test", function()
        it("should have an warn message", function()
            local warning = require "ptable.warning"

            spy.on(_G, "print")
            warning.Test("test", "It'll warn", true)
            assert.spy(_G.print).was.called()
        end)

        it("should have an warnning message", function()
            local warning = require "ptable.warning"

            spy.on(_G, "print")
            warning.Test("test", "It'll not warn", false)
            assert.spy(_G.print).was_not.called()
        end)
    end)
end)

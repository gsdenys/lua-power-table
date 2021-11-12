require "busted.runner"()

describe("Warnning", function()
    _G.print = function() end

    describe("Nil", function()
        it("should have an warn message", function()
            local warning = require "ptable.warning"
            
            spy.on(_G, "print")
            warning.Nil("test", nil)
            assert.spy(_G.print).was.called()
        end)

        it("should have an warnning message", function()
            local warning = require "ptable.warning"
            
            spy.on(_G, "print")
            warning.Nil("test", "value not nil")
            assert.spy(_G.print).was_not.called()
        end)
    end)
end)

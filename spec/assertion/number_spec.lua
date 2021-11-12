require "busted.runner"()

describe("Assertion", function()
    describe("Number", function()
        it("should have an error message", function()
            local function some_test()
                local assertion = require "ptable.assertion"

                local nb = "It is not a number"

                assertion.Number("test", nb)
            end

            local _, err = pcall(some_test)
            assert.is_not.Nil(err)
        end)

        it("should not have a nill error", function()
            local function some_test()
                local assertion = require "ptable.assertion"

                local nb = 1000 -- just a test number

                assertion.Number("test", nb)
            end

            local _, err = pcall(some_test)
            assert.Nil(err)
        end)
    end)
end)

require "busted.runner"()

describe("Assertion", function()
    describe("Table", function()
        it("should have an error message", function()
            local function some_test()
                local assertion = require "ptable.assertion"

                local test = "It is not a table"
                assertion.Table(test)
            end

            local _, err = pcall(some_test)
            assert.is_not.Nil(err)
        end)

        it("should not have a nill error", function()
            local function some_test()
                local assertion = require "ptable.assertion"

                local test = {message = "It is not a table"}

                assertion.Table(test)
            end

            local _, err = pcall(some_test)
            assert.Nil(err)
        end)
    end)
end)

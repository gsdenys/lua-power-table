require "busted.runner"()

describe("Assertion", function()
    describe("Func", function()
        it("should have an error message", function()
            local function some_test()
                local assertion = require "ptable.assertion"

                local f = "It is not a table"
                local t = {}

                assertion.Func("test", t, f)
            end

            local _, err = pcall(some_test)
            assert.is_not.Nil(err)
        end)

        it("should not have error", function()
            local function some_test()
                local assertion = require "ptable.assertion"

                local function f() end
                local t = {}

                assertion.Func("some_test", t, f)
            end

            local _, err = pcall(some_test)
            assert.Nil(err)
        end)
    end)
end)

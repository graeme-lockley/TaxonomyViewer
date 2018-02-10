module AllTests exposing (main)


import Test exposing (describe, test)
import Expect
import Bitwise
import Test.Runner.Html exposing (run)

import RippleCarryAdderTests


main =
    let
        allTests =
            describe "4-bit Ripple Carry Adder Components"
                [ RippleCarryAdderTests.inverterTests
                , RippleCarryAdderTests.andGateTests
                ]
    in
        run allTests



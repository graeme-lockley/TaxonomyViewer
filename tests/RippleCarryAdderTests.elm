module RippleCarryAdderTests exposing (main, allTests, inverterTests, andGateTests)

import Test exposing (describe, test)
import Expect
import Bitwise
import Test.Runner.Html exposing (run)


main =
    run <| allTests


allTests =
     describe "4-bit Ripple Carry Adder Components"
        [ inverterTests
        , andGateTests
        ]


inverterTests =
    describe "Inverter"
        [ test "output is 0 when the input is 1" <|
            \() ->
                inverter 0
                    |> Expect.equal 1
        , test "output is 1 when the input is 0" <|
            \() ->
                inverter 1
                    |> Expect.equal 0
        ]


andGateTests =
    describe "AND gate"
        [ test "output is 0 when both inputs are 0" <|
            \() ->
                andGate 0 0
                    |> Expect.equal 0
        , test "output is 0 when the first input is 0" <|
            \() ->
                andGate 0 1
                    |> Expect.equal 0
        , test "output is 0 when the second input is 0" <|
            \() ->
                andGate 1 0
                    |> Expect.equal 0
        , test "output is 1 when both inputs are 1" <|
            \() ->
                andGate 1 1
                    |> Expect.equal 1
        ]


andGate a b =
    Bitwise.and a b


inverter a =
    case a of
        0 ->
            1

        1 ->
            0

        _ ->
            -1


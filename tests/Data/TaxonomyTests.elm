module Data.TaxonomyTests exposing (taxonomyTests)

import Test exposing (describe, test)
import Expect

import Data.Taxonomy exposing (..)


taxonomyTests =
    describe "Taxonomy Tests"
        [ describe "isEmpty"
            [ test "item with no children should be a leaf" <|
                \() ->
                    isLeaf (Item {label = "Child", key = "C1", children = []})
                        |> Expect.true "is a leaf"
             , test "item with childen is not considered a leaf" <|
                \() ->
                    isLeaf (Item {label = "Parent", key = "P1", children = [Item {label = "Child", key = "C1", children = []}]})
                        |> Expect.false "is not a leaf"
            ]
        ]

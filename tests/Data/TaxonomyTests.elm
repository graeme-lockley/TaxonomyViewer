module Data.TaxonomyTests exposing (taxonomyTests)

import Test exposing (describe, test)
import Expect

import Data.Taxonomy exposing (..)


taxonomyTests =
    describe "Taxonomy Tests"
        [ describe "isEmpty"
            [ test "item with no children should be a leaf" <|
                \() ->
                    isLeaf (taxonomy "Child" "C1" [])
                        |> Expect.true "is a leaf"
             , test "item with childen is not considered a leaf" <|
                \() ->
                    isLeaf (taxonomy "Parent" "P1" [taxonomy "Child" "C1" []])
                        |> Expect.false "is not a leaf"
            ]
        , describe "allChildren"
            [ test "item which is a child should return itself" <|
                \() ->
                    let
                        item =
                            taxonomy "Child" "C1" []
                    in
                        allChildren item
                            |> Expect.equalLists [item]
            , test "item which is a parent should return its children" <|
                \() ->
                    let
                        children =
                            [ taxonomy "Child" "C1" []
                            , taxonomy "Child" "C2" []
                            ]

                        item =
                            taxonomy "Parent" "P1" children
                    in
                        allChildren item
                            |> Expect.equalLists children
            ]
        ]

module Data.TaxonomyTests exposing (taxonomyTests)

import Test exposing (describe, test)
import Expect

import Data.Taxonomy exposing (taxonomy)
import Data.Taxonomy as Taxonomy


simpleTaxonomy =
    taxonomy "Root" "R1"
        [ taxonomy "ParentA" "PA"
            [ taxonomy "ParentAA" "PAA"
                [ taxonomy "ChildAAA" "CAAA" []
                , taxonomy "ChildAAB" "CAAB" []
                , taxonomy "ChildAAC" "CAAC" []
                ]
            , taxonomy "ParentAB" "PAB"
                [ taxonomy "ChildABA" "CABA" []
                , taxonomy "ChildABB" "CABB" []
                , taxonomy "ChildABC" "CABC" []
                ]
            ]
       , taxonomy "ParentB" "PB"
            [ taxonomy "ParentBA" "PBA"
                [ taxonomy "ChildBAA" "CBAA" []
                , taxonomy "ChildBAB" "CBAB" []
                , taxonomy "ChildBAC" "CBAC" []
                ]
            , taxonomy "ParentAB" "PAB"
                [ taxonomy "ChildBBA" "CBBA" []
                , taxonomy "ChildBBB" "CBBB" []
                , taxonomy "ChildBBC" "CBBC" []
                ]
            ]
        ]


taxonomyTests =
    describe "Taxonomy Tests"
        [ describe "isEmpty"
            [ test "item with no children should be a leaf" <|
                \() ->
                    Taxonomy.isLeaf (taxonomy "Child" "C1" [])
                        |> Expect.true "is a leaf"
             , test "item with childen is not considered a leaf" <|
                \() ->
                    Taxonomy.isLeaf (taxonomy "Parent" "P1" [taxonomy "Child" "C1" []])
                        |> Expect.false "is not a leaf"
            ]
        , describe "allLeaves"
            [ test "item which is a child should return itself" <|
                \() ->
                    let
                        item =
                            taxonomy "Child" "C1" []
                    in
                        Taxonomy.allLeaves item
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
                        Taxonomy.allLeaves item
                            |> Expect.equalLists children
            ]
        , describe "index"
            [ test "a valid taxonomy should return a Dict index" <|
                \() ->
                    let
                        indexResult =
                            case Taxonomy.index simpleTaxonomy of
                                Ok _ -> True
                                Err _ -> False

                    in
                        indexResult
                            |> Expect.true "unable to create index for valid taxonomy"
            ]
        ]

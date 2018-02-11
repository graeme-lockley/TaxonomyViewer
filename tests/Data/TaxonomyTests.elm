module Data.TaxonomyTests exposing (taxonomyTests)

import Dict
import Expect
import Test exposing (describe, test)

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
            , taxonomy "ParentAB" "PBB"
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
            [ test "root is in index" <|
                \() ->
                        Dict.member "R1" (Taxonomy.index simpleTaxonomy)
                            |> Expect.true "Expected the root to appear in the index"
            , test "interior node is in index" <|
                \() ->
                        Dict.member "PBA" (Taxonomy.index simpleTaxonomy)
                            |> Expect.true "Expected the interior node to appear in the index"
            , test "leaf is in index" <|
                \() ->
                        Dict.member "CAAB" (Taxonomy.index simpleTaxonomy)
                            |> Expect.true "Expected the leaf to appear in the index"
            ]
        ]

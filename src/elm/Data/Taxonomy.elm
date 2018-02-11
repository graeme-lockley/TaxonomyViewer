module Data.Taxonomy exposing
    ( Taxonomy
    , allLeaves
    , index
    , isLeaf
    , taxonomy
    )


import Dict


type Taxonomy =
    Taxonomy
        { label : String
        , key : String
        , children : List Taxonomy
        }


taxonomy : String -> String -> List Taxonomy -> Taxonomy
taxonomy label key children =
    Taxonomy {label = label, key = key, children = children}


isLeaf : Taxonomy -> Bool
isLeaf (Taxonomy item) =
    List.isEmpty item.children


allLeaves : Taxonomy -> List Taxonomy
allLeaves (Taxonomy item as t) =
    if isLeaf t then
        [t]
    else
        List.concatMap allLeaves item.children


index : Taxonomy -> Result String (Dict.Dict String Taxonomy)
index t =
    let
        incorporateTaxonomyItem : Taxonomy -> Result String (Dict.Dict String Taxonomy) -> Result String (Dict.Dict String Taxonomy)
        incorporateTaxonomyItem (Taxonomy item as t) =
            Result.andThen (\idx ->
                if Dict.member item.key idx then
                    Err <| "Duplicate key " ++ item.key
                else
                    Ok <| Dict.insert item.key t idx)

        incorporateTaxonomy : Taxonomy -> Result String (Dict.Dict String Taxonomy) -> Result String (Dict.Dict String Taxonomy)
        incorporateTaxonomy (Taxonomy item as t) rs =
            incorporateChildren item.children
                <| incorporateTaxonomyItem t
                <| rs

        incorporateChildren : List Taxonomy -> Result String (Dict.Dict String Taxonomy) -> Result String (Dict.Dict String Taxonomy)
        incorporateChildren rs idx =
            List.foldl incorporateTaxonomy idx rs
    in
        incorporateTaxonomy t (Ok Dict.empty)
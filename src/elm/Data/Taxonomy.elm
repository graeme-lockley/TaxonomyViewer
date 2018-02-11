module Data.Taxonomy exposing
    ( Taxonomy
    , allLeaves
    , isLeaf
    , taxonomy
    )


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
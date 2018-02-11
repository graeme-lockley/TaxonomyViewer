module Data.Taxonomy exposing
    ( Taxonomy
    , allChildren
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


allChildren : Taxonomy -> List Taxonomy
allChildren t =
    case t of
        Taxonomy item ->
            if isLeaf t then
                [t]
            else
                List.concatMap allChildren item.children
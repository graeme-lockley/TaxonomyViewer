module Data.Taxonomy exposing (Taxonomy(..), isLeaf)


type Taxonomy =
    Item
    { label : String
    , key : String
    , children : List Taxonomy
    }


isLeaf : Taxonomy -> Bool
isLeaf (Item item) =
    List.isEmpty item.children


--allChildren : Taxonomy -> List Taxonomy
--allChildren (Item item) =
--    if List.length item.children == 0 then
--        []
--    else
--        List.flatten (List.map allChildren )
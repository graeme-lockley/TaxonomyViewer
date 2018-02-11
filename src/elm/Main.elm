import Html exposing (..)
import Html.Events exposing (onClick)


type alias Model = { counter : Int }


type Action = NoOp | Inc | Dec


update : Action -> Model -> ( Model, Cmd Action)
update action model =
  case action of
    NoOp -> (model, Cmd.none)
    Inc -> ({ model | counter = model.counter + 1}, Cmd.none)
    Dec -> ({ model | counter = model.counter - 1}, Cmd.none)


view : Model -> Html Action
view model =
    div []
        [ table []
            [
            ]
        , div [] [text "Counter"]
        , div [] [text ("From model :: " ++ (toString model))]
        , div []
            [ button [onClick Dec] [text "--"]
            , span [] [text (toString model)]
            , button [onClick Inc] [text "++"]
            ]
        ]



init : ( Model, Cmd Action )
init =
  ({counter = 0}, Cmd.none)


subscriptions : Model -> Sub Action
subscriptions model =
  Sub.none


main =
  Html.program {init = init, update = update, view = view, subscriptions = subscriptions}
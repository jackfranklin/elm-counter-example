module CounterExample (..) where

import Html exposing (..)
import Html.Events exposing (onClick)


type alias Model =
    { count : Int }


initialModel : Model
initialModel =
    { count = 0 }


type Action
    = Increment
    | Decrement
    | NoOp


actions : Signal.Mailbox Action
actions =
    Signal.mailbox NoOp


update : Action -> Model -> Model
update action model =
    case action of
        NoOp ->
            model

        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }


view : Signal.Address Action -> Model -> Html
view address model =
    div
        []
        [ h1 [] [ text ("Counter " ++ (toString model.count)) ]
        , button [ onClick address Increment ] [ text "Increment" ]
        , button [ onClick address Decrement ] [ text "Decrement" ]
        ]


model : Signal Model
model =
    Signal.foldp update initialModel actions.signal


main : Signal Html
main =
    Signal.map (view actions.address) model

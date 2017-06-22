import Html exposing (Html, button, div, text, p, details, summary, h3, input)
import Html.Attributes exposing (placeholder)
import Html.Events exposing (onClick, onInput)

main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL
type alias Model =
  { count: Int
  , reversed: String
  }


model: Model
model =
  Model 0 ""

-- UPDATE
type Msg = Increment
         | Decrement
         | Change String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment -> { model | count = model.count + 1 }
    Decrement -> { model | count = model.count - 1 }
    Change x -> { model | reversed = String.reverse x }


-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ details []
        [ summary [] [
            h3 [] [ text "Reverse a string" ]
          ]
        , input [ placeholder "Type some text to reverse"
            , onInput Change
          ] []
        , p [] [ text model.reversed ]
        ]
    , details []
        [ summary [] [
            h3 [] [ text "Increment/Decrement" ]
          ]
        , button [ onClick Decrement ] [ text "-" ]
        , text (toString model.count)
        , button [ onClick Increment ] [ text "+" ]
        ]
  ]

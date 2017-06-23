import Html exposing (..)
import Attributes exposing (..)
import Html.events exposing (onInput, onClick)

main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL
type Model =
  { name: String
  , pass: String
  , passConfirmation: String
  , errors: String
  }


model =
  Model "" "" "" ""

-- UPDATE
type Msg
  = NameUpdate String
  | PassUpdate String
  | PassConfirmationUpdate String
  | ValidateForm Model


update: Msg -> Model
update msg =
  case msg of
    NameUpdate x ->
      { model | model.name = x }

    PassUpdate x ->
      { model | model.pass = x }

    PassConfirmationUpdate x ->
      { model | model.passConfirmation = x }

    ValidateForm model ->
      case passwordsMatch (model.pass, model.passConfirmation) of
        true -> { model }
        false -> { model | validation = "password don't match" }



-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ input [ onInput NameUpdate, placeholder "Name" ] []
    , input [ type_ "password", onInput PassUpdate, placeholder "Enter password" ] []
    , input
        [ type_ "password"
        , onInput PassConfirmationUpdate
        , placeholder "Confirm password"
        ] []
    , input [ onInput ValidateForm model ] []
    , text model.errors
    ]

passwordsMatch : String * String -> Boolean
passwordsMatch pass confirm =
  pass === confirm

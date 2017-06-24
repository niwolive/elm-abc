import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL
type alias Model =
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


update: Msg -> Model -> Model
update msg model =
  case msg of
    NameUpdate x ->
      { model | name = x }

    PassUpdate x ->
      { model | pass = x }

    PassConfirmationUpdate x ->
      { model | passConfirmation = x }

    ValidateForm model ->
      if passwordsMatch (model.pass, model.passConfirmation)
        then { model | errors = "" }
        else { model | errors = "password don't match" }



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
    , input [ type_ "button", onClick (ValidateForm model), value "Submit" ] []
    , text model.errors
    ]

passwordsMatch : (String, String) -> Bool
passwordsMatch (pass, confirm) =
  pass == confirm

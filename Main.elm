import Html
import Data exposing (init, update, subscriptions, Model, Msg)
import View.Main exposing (view)

-- Program

main : Program Never Model Msg
main = Html.program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

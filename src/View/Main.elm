module View.Main exposing (view)

import Data exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

import View.Style exposing (..)

view : Model -> Html Msg
view model =
  Html.div [ class "app" ]
  [
    Html.div [ styleControls ]
      [ viewCurrentTime model.playerStatus
      , viewLoadVideoForm model.videoId
      , viewControls
      ]
  , viewProgress model.playerStatus
  ]

viewCurrentTime : PlayerStatus -> Html Msg
viewCurrentTime playerStatus =
  Html.div [ styleCurrentTime ]
    [ text <| List.foldr (++) ""
      [ (toString <| floor playerStatus.currentTime // 60)
      , ":"
      , (toString <| floor playerStatus.currentTime % 60)
      ]
    ]

viewControls =
  Html.div []
    [ Html.button [ styleButton, onClick PlayVideo ] [ text "Start" ]
    , Html.button [ styleButton, onClick StopVideo ] [ text "Stop" ]
    , Html.button [ styleButton, onClick PauseVideo ] [ text "Pause" ]
    ]

viewLoadVideoForm : String -> Html Msg
viewLoadVideoForm videoId =
  Html.form []
    [ Html.input [ styleInput, type_ "text" , value videoId ] [] ]

viewProgress : PlayerStatus -> Html Msg
viewProgress playerStatus =
  Html.div
    [ styleProgress playerStatus.progress
    ] []

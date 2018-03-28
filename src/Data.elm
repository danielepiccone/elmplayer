module Data exposing (..)

import Mouse
import Window
import Task
import Ports exposing (..)
import Json.Decode exposing (..)

-- Model

type alias PlayerStatus =
  { progress: Float
  , currentTime: Float
  , duration: Float
}

type alias Model =
  { count : Int
  , videoId : String
  , playerStatus: PlayerStatus
  , mousePosition: Mouse.Position
  , windowSize: Window.Size
  }

init : ( Model, Cmd Msg )
init = (
  { count = 0
  , videoId = "I2dfGC1oziE"
  , playerStatus =
    { progress = 0
    , currentTime = 0
    , duration = 0
    }
  , mousePosition =
    { x = 0
    , y = 0
    }
  , windowSize =
    { width = 0
    , height = 0
    }
  }, Cmd.batch
    [ Ports.loadVideoById "I2dfGC1oziE"
    , Task.perform WindowResize Window.size
    ]
  )

-- Update

type Msg
  = UpdatePlayerStatus (Result String PlayerStatus)
  | MouseClick Mouse.Position
  | WindowResize Window.Size

  | PlayVideo
  | StopVideo
  | PauseVideo
  | SeekTo Int


update: Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    UpdatePlayerStatus x ->
      case x of
        Err err -> ( model, Cmd.none )
        Ok val -> ( { model | playerStatus = val }, Cmd.none )
    MouseClick position -> ({ model | mousePosition = position }, Cmd.none )
    WindowResize size -> ({ model | windowSize = size }, Cmd.none )
    PlayVideo -> ( model, Ports.playVideo ())
    StopVideo -> ( model, Ports.stopVideo ())
    PauseVideo -> ( model, Ports.pauseVideo ())
    SeekTo timeSecs -> ( model, Ports.seekTo timeSecs)

-- Subscriptions

playerStatusDecoder: Decoder PlayerStatus
playerStatusDecoder =
  map3 PlayerStatus
    (at ["progress"] float)
    (at ["currentTime"] float)
    (at ["duration"] float)

decodePlayerStatus: Value -> Result String PlayerStatus
decodePlayerStatus value = decodeValue playerStatusDecoder value

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ Ports.playerStatus (\x -> UpdatePlayerStatus (decodePlayerStatus x))
    , Mouse.clicks MouseClick
    , Mouse.clicks (\{x, y} -> SeekTo ((floor model.playerStatus.duration) * x // model.windowSize.width))
    , Window.resizes WindowResize
    ]

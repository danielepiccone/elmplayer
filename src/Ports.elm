port module Ports exposing (..)
import Json.Decode exposing (Value)

-- Subcriptions

port playerStatus: (Value -> msg) -> Sub msg

-- Commands

port loadVideoById: String -> Cmd msg
port playVideo: () -> Cmd msg
port stopVideo: () -> Cmd msg
port pauseVideo: () -> Cmd msg
port seekTo: Int -> Cmd msg

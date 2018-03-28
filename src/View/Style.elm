module View.Style exposing (..)

import Html exposing (Attribute)
import Html.Attributes exposing (style)

styleButton =
  style
  [ ("cursor", "pointer")
  , ("padding", "0.5rem 1rem")
  , ("color", "white")
  , ("backgroundColor", "rgba(0, 0, 0, 0.1)")
  , ("border", "none")
  , ("borderRadius", "1rem")
  ]

styleProgress : Float -> Attribute msg
styleProgress progress =
  Html.Attributes.style
    [ ("backgroundColor", "rgba(0,0,0,0.4)")
    , ("pointerEvents", "none")
    , ("position", "absolute")
    , ("height", "100%")
    , ("transition", "1s width linear")
    , ("width", toString (100 * progress) ++ "%")
    ]

styleControls =
  style
  [ ("display", "flex")
  , ("flexDirection", "column")
  , ("alignItems", "center")
  , ("justifyContent", "center")
  , ("height", "100vh")
  ]

styleCurrentTime =
  style
  [ ("fontSize", "10rem")
  , ("fontFamily", "sans-serif")
  , ("color", "white")
  ]

styleInput =
  style
  [ ("backgroundColor", "transparent")
  , ("color", "white")
  , ("fontSize", "2rem")
  , ("borderWidth", "0 0 1px 0")
  , ("borderColor", "white")
  , ("marginBottom", "2rem")
  , ("textAlign", "center")
  ]

module View.Avatar exposing (..)

import Element exposing (..)
import Element.Attributes exposing (..)
import Styles exposing (..)


avatarFrame style attrs frameBody =
    row style
        ([ width <| fill 1
         , paddingLeft 20
         , paddingRight 20
         , paddingTop 10
         , paddingBottom 20
         , spacing 10
         , attribute "data-class" "flex-fix"
         ]
            ++ attrs
        )
        [ avatar
        , el None
            [ paddingTop 6, width <| fill 1 ]
            frameBody
        ]


avatar =
    image "http://i.pravatar.cc/30"
        Avatar
        [ width (px 30)
        , height (px 30)
        ]
        empty

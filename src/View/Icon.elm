module View.Icon exposing (..)

import Element exposing (..)
import Element.Attributes exposing (..)
import Svg
import Svg.Attributes


type alias Icons =
    { pencil1 : Icon
    }


type alias Icon =
    { id : String
    , content : String
    , viewBox : String
    }


pencil2 =
    icon "pencil-2"


icon iconName style attributes =
    el style (attribute "role" "presentation" :: attributes) <|
        html <|
            Svg.svg
                [ Svg.Attributes.style "width: 1em; height: 1em; fill: currentColor;"
                ]
                [ Svg.use
                    [ Svg.Attributes.xlinkHref ("assets/icons.svg#" ++ iconName)
                    ]
                    []
                ]


icon2 icon style attributes =
    el style (attribute "role" "presentation" :: attributes) <|
        html <|
            Svg.svg
                [ Svg.Attributes.style "width: 1em; height: 1em; fill: currentColor;"
                ]
                [ Svg.use
                    [ Svg.Attributes.xlinkHref ("#" ++ icon.id)
                    ]
                    []
                ]

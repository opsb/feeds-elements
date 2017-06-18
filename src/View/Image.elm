module View.Image exposing (proportional)

import Element exposing (..)
import Element.Attributes exposing (..)
import Styles exposing (..)
import Utils exposing ((=>))


proportional imageSrc =
    image
        imageSrc
        None
        [ inlineStyle
            [ "width" => "100%"
            , "display" => "block"
            , "height" => "auto"
            ]
        ]
        empty

module Utils exposing (..)

import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onWithOptions)
import Json.Decode as JD


(=>) : a -> b -> ( a, b )
(=>) a b =
    ( a, b )


flexFix =
    attribute "data-class" "flex-fix"


onClickNoProp msg =
    onWithOptions "click" { stopPropagation = True, preventDefault = True } (JD.succeed msg)

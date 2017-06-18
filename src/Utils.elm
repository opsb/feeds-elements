module Utils exposing (..)

import Element exposing (..)
import Element.Attributes exposing (..)


(=>) : a -> b -> ( a, b )
(=>) a b =
    ( a, b )


flexFix =
    attribute "data-class" "flex-fix"

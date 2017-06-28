module View.Icon exposing (verticalDots)

import Element exposing (..)
import Element.Attributes exposing (..)
import Style exposing (..)
import Styles exposing (..)
import Utils exposing ((=>))


verticalDots attributes =
    el (Icon ShowMoreVertical) attributes empty

module Msg exposing (..)

import Route exposing (Route)


type Msg
    = NavigateTo Route
    | SetRoute Route

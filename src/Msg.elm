module Msg exposing (..)

import Mouse
import Route exposing (Route)


type Msg
    = NavigateTo Route
    | SetRoute Route
    | ToggleMenu String
    | MouseClick Mouse.Position

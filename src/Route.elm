module Route exposing (Route(..), fromLocation, toUrl)

import Navigation


type Route
    = Feed
    | Conversation
    | NotFound


toUrl : Route -> String
toUrl route =
    case route of
        Feed ->
            "feed"

        Conversation ->
            "conversation"

        NotFound ->
            "not_found"


fromLocation : Navigation.Location -> Route
fromLocation location =
    case Debug.log "from location" location.pathname of
        "/" ->
            Feed

        "/feed" ->
            Feed

        "/conversation" ->
            Conversation

        _ ->
            NotFound

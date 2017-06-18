module Page.Feed exposing (view)

import Element exposing (..)
import Element.Attributes exposing (..)
import Styles exposing (..)
import View.Avatar as Avatar


view =
    row MainColumn
        [ width <| fill 1, center ]
        [ column None
            [ alignLeft
            , width <| px 720
            , center
            ]
            [ conversationCards ]
        ]


conversationCards =
    column ConversationCard
        [ width <| fill 1 ]
        [ conversationCard
        ]


conversationCard =
    Avatar.avatarFrame None [] <|
        el None [] (text "boom")

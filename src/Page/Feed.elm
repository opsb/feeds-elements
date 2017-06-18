module Page.Feed exposing (view)

import Element exposing (..)
import Element.Attributes exposing (..)
import Styles exposing (..)
import Utils exposing ((=>), flexFix)
import View.Avatar as Avatar
import View.Image as Image


view =
    row MainColumn
        [ width <| fill 1, center, flexFix ]
        [ column None
            [ alignLeft
            , width <| px 720
            , center
            , flexFix
            , spacing 20
            , paddingXY 0 20
            ]
            [ conversationCard <| Just "https://placeimg.com/640/400/any?e=1"
            , conversationCard <| Nothing
            , conversationCard <| Just "https://placeimg.com/640/400/any?e=2"
            , conversationCard <| Just "https://placeimg.com/640/400/any?e-3"
            ]
        ]


conversationCard maybeImage =
    el ConversationCard [ width <| fill 1 ] <|
        row None
            [ flexFix ]
            (case maybeImage of
                Just image ->
                    [ conversationCardDetails
                    , conversationCardImage image
                    ]

                Nothing ->
                    [ conversationCardDetails
                    ]
            )


conversationCardDetails =
    Avatar.avatarFrame None [] <|
        column None
            [ flexFix, height <| fill 1 ]
            [ row None
                [ spacing 10, paddingBottom 7, flexFix ]
                [ el MessageUsername [] (text "Message title")
                , el MessageTime [] (text "08:00am")
                ]
            , el ConversationCardTitle [ height <| fill 1, paddingBottom 20 ] (text "Big title")
            , row None
                [ spacing 10, verticalCenter ]
                [ participants
                , el ConversationCardResponsesCount [] (text "10 responses")
                ]
            ]


conversationCardImage image =
    el None
        [ width <| px 200 ]
        (Image.proportional image)


participants =
    row None
        [ spacing -5 ]
        [ Avatar.avatarSmall
        , Avatar.avatarSmall
        , Avatar.avatarSmall
        , Avatar.avatarSmall
        , Avatar.avatarSmall
        ]

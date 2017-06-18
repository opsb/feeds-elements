module Page.Frame exposing (view)

import Element exposing (..)
import Element.Attributes exposing (..)
import Styles exposing (..)
import Utils exposing ((=>))


view body =
    column Main
        [ height <| fill 1 ]
        [ navbar
        , row None
            [ height <| percent 100
            , width <| fill 1
            ]
            [ sideBar, body, inspector ]
        ]


navbar =
    el Paper
        [ padding 20 ]
        (row None
            [ spacing 20 ]
            [ link "#feed" <| el None [] (text "Feed")
            , link "#conversation" <| el None [] (text "Conversation")
            ]
        )


sideBar =
    column SideBar
        [ paddingXY 10 15
        , alignLeft
        , width <| px 250
        ]
        [ el SideBarTitle [ paddingXY 20 10 ] (text "Topics")
        , column Nav
            [ paddingXY 0 10, width <| fill 1 ]
            [ el NavLink [ paddingXY 20 10 ] (text "One")
            , el NavLink [ vary Active True, paddingXY 20 10 ] (text "Two")
            , el NavLink [ paddingXY 20 10 ] (text "Three")
            , el NavLink [ paddingXY 20 10 ] (text "Four")
            ]
        ]


inspector =
    column Inspector
        [ padding 20
        , alignLeft
        , width <| px 200
        , height <| fill 1
        ]
        [ text "Inspector" ]

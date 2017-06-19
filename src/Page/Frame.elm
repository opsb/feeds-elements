module Page.Frame exposing (view)

import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (..)
import Msg exposing (..)
import Route
import Styles exposing (..)
import Utils exposing ((=>), flexFix)


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
            [ el Link [ onClick <| NavigateTo Route.Feed ] (text "Feed")
            , el Link [ onClick <| NavigateTo Route.Conversation ] (text "Conversation")
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
            [ navLink "One"
            , el NavLink [ vary Active True, paddingXY 20 10, onClick <| NavigateTo Route.Feed ] (text "Two")
            , el NavLink [ paddingXY 20 10, onClick <| NavigateTo Route.Feed ] (text "Three")
            , el NavLink [ paddingXY 20 10, onClick <| NavigateTo Route.Feed ] (text "Four")
            ]
        ]


navLink label =
    el NavLink [ paddingXY 20 10, onClick <| NavigateTo Route.Feed ] (text label)
        |> within
            [ el None [ alignRight ] (text "menu") ]


inspector =
    column Inspector
        [ padding 20
        , alignLeft
        , width <| px 200
        , height <| fill 1
        ]
        [ text "Inspector" ]

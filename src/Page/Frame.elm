module Page.Frame exposing (view)

import DefaultDict
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (..)
import Html
import Html.Attributes
import Msg exposing (..)
import Route
import Styles exposing (..)
import Utils exposing ((=>), flexFix, onClickNoProp)
import View.Icon as Icon


view model body =
    column Main
        [ height <| fill 1 ]
        [ navbar
        , row None
            [ height <| percent 100
            , width <| fill 1
            ]
            [ sideBar model, body, inspector ]
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


sideBar model =
    column SideBar
        [ paddingXY 10 15
        , alignLeft
        , width <| px 250
        ]
        [ el SideBarTitle [ paddingXY 20 10 ] (text "Topics")
        , column Nav
            [ paddingXY 0 10, width <| fill 1 ]
            [ navLink model "One"
            , el NavLink [ vary Active True, paddingXY 20 10, onClick <| NavigateTo Route.Feed ] (text "Two")
            , el NavLink [ paddingXY 20 10, onClick <| NavigateTo Route.Feed ] (text "Three")
            , el NavLink [ paddingXY 20 10, onClick <| NavigateTo Route.Feed ] (text "Four")
            ]
        ]


navLink model label =
    el NavLink [ paddingXY 20 10, width <| fill 1, onClick <| NavigateTo Route.Feed ] (text label)
        |> within
            [ dropdownMenu { onToggle = ToggleMenu label } (DefaultDict.get label model.menus)
            ]


dropdownMenu { onToggle } isOpen =
    el None
        [ alignRight, verticalCenter, paddingRight 5, onClickNoProp onToggle ]
        (el DropdownTrigger [ padding 3 ] empty)
        |> below
            [ when isOpen <|
                column DropdownMenu
                    [ inlineStyle [ "z-index" => "1000" ]
                    , moveDown 5
                    ]
                    [ row DropdownMenuItem
                        [ paddingXY 20 15
                        , inlineStyle [ "white-space" => "nowrap" ]
                        , minWidth (px 150)
                        ]
                        [ Icon.pencil2 DropdownMenuIcon [], el None [ paddingLeft 5 ] (text "Edit") ]
                    ]
            , when isOpen <|
                screenCover
            ]


screenCover =
    screen <| el ScreenCover [ width <| fill 1, height <| fill 1 ] empty


inspector =
    column Inspector
        [ padding 20
        , alignLeft
        , width <| px 200
        , height <| fill 1
        ]
        [ text "Inspector" ]

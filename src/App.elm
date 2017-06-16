module App exposing (..)

import Color exposing (Color, rgba)
import Color.Convert
import Element exposing (..)
import Element.Attributes exposing (..)
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font
import Style.Transition as Transition


type Styles
    = None
    | Container
    | Label
    | Navbar
    | NavLink
    | SideBar
    | SideBarTitle
    | Nav
    | Inspector
    | MessageBox
    | Chat
    | Main
    | H3


type Variations
    = Active


hex : String -> Color
hex hexValue =
    case Color.Convert.hexToColor hexValue of
        Ok color ->
            color

        Err error ->
            Debug.crash error


colors =
    { darken = rgba 0 0 0 0.25
    , mediumGrey = hex "#424242"
    , lightGrey = rgba 158 158 158 1
    , red = rgba 232 90 82 1
    , mauve = rgba 176 161 186 1
    , blue1 = rgba 165 181 191 1
    , blue2 = rgba 171 200 199 1
    , green1 = rgba 184 226 200 1
    , green2 = rgba 191 240 212 1
    }


stylesheet : StyleSheet Styles Variations
stylesheet =
    Style.stylesheet
        [ style None []
        , style Main [ Font.typeface [ "Lato", "Helvetica Neue", "Helvetica", "Arial", "sans-serif" ] ]
        , style Container
            [ Color.text Color.black
            , Color.background colors.blue2
            , Color.border Color.lightGrey
            ]
        , style Chat
            [ Color.background colors.blue1
            ]
        , style Navbar
            [ Color.background colors.mauve
            ]
        , style SideBar
            [ Color.background colors.mediumGrey
            ]
        , style NavLink
            [ Color.text colors.lightGrey
            , Font.size 14
            , hover
                [ Color.background colors.darken
                , Border.rounded 5
                , Color.text Color.white
                , cursor "pointer"
                ]
            , variation Active
                [ Color.background colors.red
                , Color.text Color.white
                , Border.rounded 5
                ]
            ]
        , style SideBarTitle
            [ Color.text Color.white
            , Font.uppercase
            , Font.size 12
            ]
        , style Inspector
            [ Color.background colors.green2
            ]
        , style MessageBox
            [ Color.background colors.blue2 ]
        , style H3
            [ Font.size 20, Font.weight 400 ]
        ]


main =
    Element.viewport stylesheet <|
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
    el Navbar [ padding 20 ] (text "Navbar")


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


body =
    column None
        [ alignLeft
        , width <| fill 1
        ]
        [ messages, messageBox ]


messages =
    column
        Chat
        [ width <| fill 1
        , alignLeft
        , yScrollbar
        ]
        (List.map message <| List.range 1 100)


message n =
    el None
        [ padding 10 ]
        (text <| "message" ++ toString n)


messageBox =
    el MessageBox
        [ height <| px 300
        , width <| fill 1
        , verticalCenter
        ]
        (text "Message box")

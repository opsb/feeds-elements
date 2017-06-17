module App exposing (..)

import Color exposing (Color, rgba)
import Color.Convert
import Element exposing (..)
import Element.Attributes exposing (..)
import Html.Attributes
import Markdown
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font
import Style.Shadow as Shadow


type Styles
    = None
    | Avatar
    | Chat
    | Container
    | DiscussionHeader
    | H3
    | Inspector
    | Label
    | Main
    | MainColumn
    | MessageBox
    | MessageUsername
    | MessageTime
    | Nav
    | Navbar
    | NavLink
    | Paper
    | SideBar
    | SideBarTitle
    | TextArea


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
    , darken2 = rgba 33 33 33 0.15
    , mediumGrey = hex "#424242"
    , lightGrey = rgba 158 158 158 1
    , veryLightGrey = rgba 245 245 245 1
    , lightestGrey = rgba 250 250 250 1
    , transparentGrey = rgba 33 33 33 0.15
    , red = rgba 232 90 82 1
    , mauve = rgba 176 161 186 1
    , blue1 = rgba 165 181 191 1
    , blue2 = rgba 171 200 199 1
    , green1 = rgba 184 226 200 1
    , green2 = rgba 191 240 212 1
    , transparent = rgba 255 255 255 0
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
            [ Color.background Color.white
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
            , variation Active
                [ Color.background colors.red
                , Color.text Color.white
                , Border.rounded 5
                , hover
                    [ Color.background colors.red
                    , Color.text Color.white
                    , Border.rounded 5
                    ]
                ]
            , hover
                [ Color.background colors.darken
                , Border.rounded 5
                , Color.text Color.white
                , cursor "pointer"
                , variation Active
                    [ Color.background colors.red
                    , Color.text Color.white
                    , Border.rounded 5
                    ]
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
            [ Color.background colors.lightestGrey
            , Style.shadows
                [ Shadow.inset
                    { offset = ( 0, 6 )
                    , size = -6
                    , blur = 5
                    , color = colors.darken2
                    }
                ]
            ]
        , style MessageUsername
            [ Font.weight 700
            , Font.size 13.5
            ]
        , style MessageTime
            [ Font.size 12
            , Color.text colors.lightGrey
            ]
        , style TextArea
            [ Color.text colors.lightGrey
            , Color.background colors.transparent
            , Font.size 14
            , prop "resize" "none"
            , pseudo "placeholder"
                [ Color.text Color.white
                ]
            , focus
                [ Style.prop "outline" "none"
                ]
            ]
        , style H3
            [ Font.size 20, Font.weight 400 ]
        , style MainColumn
            [ Color.background colors.veryLightGrey ]
        , style Paper
            [ Style.shadows
                [ Shadow.box
                    { offset = ( 0, 1 )
                    , size = 0
                    , blur = 4
                    , color = colors.transparentGrey
                    }
                ]
            ]
        , style DiscussionHeader
            [ Color.background Color.white
            , Border.bottom 1
            , Border.solid
            , Color.border colors.veryLightGrey
            ]
        , style Avatar
            [ prop "border-radius" "50%"
            ]
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
    el Paper [ padding 20 ] (text "Navbar")


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
    row MainColumn
        [ width <| fill 1, center ]
        [ column Paper
            [ alignLeft
            , width <| px 720
            , center
            ]
            [ discussionHeader
            , messages
            , messageBox
            ]
        ]


discussionHeader =
    avatarFrame DiscussionHeader
        []
        (el None [ width <| fill 1 ] (text "Some title"))


messages =
    column
        Chat
        [ width <| fill 1
        , alignLeft
        , yScrollbar
        ]
        (List.concatMap messageSequence <| steppedRange 4 0 80)


messageSequence i =
    [ firstMessage i ] ++ (List.range 1 3 |> List.map (\j -> followingMessage (i + j)))


firstMessage n =
    messageRow
        (column None
            []
            [ row None
                [ spacing 10, paddingBottom 5 ]
                [ el MessageUsername [] (text "Message title")
                , el MessageTime [] (text "08:00am")
                ]
            , message n
            ]
            |> onLeft [ el None [ alignLeft, paddingRight 10 ] avatar ]
        )


followingMessage n =
    messageRow
        (el None
            [ paddingTop 6, width <| fill 1 ]
            (message n)
        )


messageRow body =
    el None
        [ width <| fill 1
        , paddingLeft 60
        , paddingRight 20
        , paddingTop 10
        , paddingBottom 20
        , spacing 10
        , alignTop
        , attribute "data-class" "row"
        ]
        body


message n =
    el None
        []
        (html <|
            Markdown.toHtml [ Html.Attributes.class "markdown" ] <|
                (lorem ++ paragraphs)
        )


trimLeading =
    String.lines >> List.map String.trimLeft >> String.join "\n"


messageBox =
    avatarFrame MessageBox
        []
        (textArea TextArea
            [ width <| fill 1
            , placeholder "Wisdom, thoughts or just words..."
            ]
            "Some text"
        )


avatarFrame style attrs frameBody =
    row style
        ([ width <| fill 1
         , paddingLeft 20
         , paddingRight 20
         , paddingTop 10
         , paddingBottom 20
         , spacing 10
         , attribute "data-class" "row"
         ]
            ++ attrs
        )
        [ avatar
        , el None
            [ paddingTop 6, width <| fill 1 ]
            frameBody
        ]


avatar =
    image "http://i.pravatar.cc/30"
        Avatar
        [ width (px 30)
        , height (px 30)
        ]
        empty



-- HELPERS


steppedRange stepSize start end =
    List.range start (end // stepSize) |> List.map ((*) stepSize)


lorem =
    "Donec interdum elementum aliquam. Maecenas cursus sem tellus, id elementum elit condimentum eget. Proin quis massa mi. In fermentum risus at quam tristique vestibulum. Quisque convallis odio in sodales euismod. Maecenas convallis nec justo nec facilisis. Nam lobortis sem eget sem consectetur, nec pretium leo dictum. Quisque blandit nibh quis tortor vehicula sodales. Proin non leo non dui dictum rhoncus quis et magna. Quisque in nunc eros. Aliquam erat volutpat. Etiam at efficitur lacus."


paragraphs =
    trimLeading <|
        """
        paragraph1

        paragraph2
        """

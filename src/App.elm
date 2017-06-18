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


(=>) a b =
    ( a, b )


type Styles
    = None
    | AttachmentSummary
    | AttachmentTitle
    | Avatar
    | Chat
    | Container
    | DayTitle
    | DiscussionHeader
    | DiscussionHeaderTitle
    | EditMessage
    | EditMessageRow
    | H3
    | Inspector
    | Label
    | Main
    | MainColumn
    | MessageBox
    | MessageRow
    | MessageTime
    | MessageUsername
    | ConversationOverview
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
    , mediumGrey = rgba 66 66 66 1
    , mediumGrey2 = rgba 97 97 97 1
    , lightGrey = rgba 158 158 158 1
    , veryLightGrey = rgba 245 245 245 1
    , lightestGrey = rgba 250 250 250 1
    , transparentGrey = rgba 33 33 33 0.15
    , blue = rgba 2 136 209 1
    , red = rgba 232 90 82 1
    , mauve = rgba 176 161 186 1
    , blue1 = rgba 165 181 191 1
    , blue2 = rgba 171 200 199 1
    , green1 = rgba 184 226 200 1
    , green2 = rgba 191 240 212 1
    , transparent = rgba 255 255 255 0
    }


shadows =
    { insetTop =
        Shadow.inset
            { offset = ( 0, 6 )
            , size = -6
            , blur = 5
            , color = colors.darken2
            }
    , insetBottom =
        Shadow.inset
            { offset = ( 0, -6 )
            , size = -6
            , blur = 5
            , color = colors.darken2
            }
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
                [ shadows.insetTop
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
        , style MessageRow
            [ hover
                [ Color.background colors.lightestGrey
                ]
            ]
        , style EditMessageRow
            [ Border.all 0
            , Color.border Color.blue
            , Style.shadows [ shadows.insetTop, shadows.insetBottom ]
            , Color.background colors.lightestGrey
            ]
        , style EditMessage
            []
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
        , style DiscussionHeaderTitle
            [ Font.weight 300
            ]
        , style Avatar
            [ prop "border-radius" "50%"
            ]
        , style DayTitle
            [ Color.background Color.white
            , Color.text colors.mediumGrey2
            , Font.center
            , Font.uppercase
            , Font.size 12
            , pseudo "after"
                [ Border.bottom 1
                , prop "content" "boom"
                ]
            ]
        , style AttachmentTitle
            [ Color.text colors.blue
            , Font.size 14
            , Font.lineHeight 1.4
            ]
        , style AttachmentSummary
            [ Color.text colors.mediumGrey2
            , Font.size 12
            , Font.lineHeight 1.5
            ]
        , style ConversationOverview
            [ Color.background Color.white
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
            , scrollPane
            , messageBox
            ]
        ]


discussionHeader =
    avatarFrame DiscussionHeader
        []
        (el DiscussionHeaderTitle [ width <| fill 1 ] (text "Some title"))


scrollPane =
    column None
        [ yScrollbar ]
        [ conversationAttachments "https://i.guim.co.uk/img/media/1e698be526bf7a2288256d859f95690e5db3599a/2_0_1300_780/master/1300.png?w=1200&h=630&q=55&auto=format&usm=12&fit=crop&crop=faces%2Centropy&bm=normal&ba=bottom%2Cleft&blend64=aHR0cHM6Ly91cGxvYWRzLmd1aW0uY28udWsvMjAxNi8wNS8yNS9vdmVybGF5LWxvZ28tMTIwMC05MF9vcHQucG5n&s=ad2c97aeca6410e9ebfd095ece4f1a8e"
        , conversationAttachments "http://images.techhive.com/images/article/2017/05/digital-disruption_primary4-100720489-large.3x2.jpg"
        , conversationAttachments "http://d1ri6y1vinkzt0.cloudfront.net/media/images/Medium/4c77e705-14c2-4aaa-bf28-25ca5bf89937.jpg?v=-8298800"
        , discussionDay "Day one"
        , discussionDay "Day two"
        ]


conversationAttachments imageSrc =
    row ConversationOverview
        [ attribute "data-class" "flex-fix", padding 20, spacing 20 ]
        [ el None [ inlineStyle [ "max-width" => "75%", "max-height" => "275px" ] ] (proportionalImage imageSrc)
        , attachmentSummary
        ]


messageAttachments imageSrc =
    row ConversationOverview
        [ attribute "data-class" "flex-fix", spacing 20 ]
        [ el None [ inlineStyle [ "max-width" => "50%" ] ] (proportionalImage imageSrc)
        , attachmentSummary
        ]


attachmentSummary =
    textLayout None
        [ spacing 10, inlineStyle [ "flex-shrink" => "10" ] ]
        [ el AttachmentTitle [] (text "'Unprecedented public stroke-fest': late-night hosts on Trump's cabinet meeting")
        , paragraph AttachmentSummary [] [ text "Comics, including Stephen Colbert, Trevor Noah and Seth Meyers, took aim at the president’s bizarre inaugural cabinet meeting on Monday" ]
        ]


proportionalImage imageSrc =
    image
        imageSrc
        None
        [ inlineStyle
            [ "width" => "100%"
            , "display" => "block"
            , "height" => "auto"
            ]
        ]
        empty


discussionDay title =
    column None
        [ attribute "data-class" "flex-fix" ]
        [ dayTitle title
        , messages
        ]


dayTitle title =
    column None
        [ attribute "data-class" "flex-fix" ]
        [ el DayTitle
            [ width <| fill 1
            , center
            , verticalCenter
            , paddingTop 30
            , paddingBottom 10
            ]
            (text title)
        ]


messages =
    column
        Chat
        [ width <| fill 1
        , alignLeft
        ]
        (List.concatMap messageSequence <| steppedRange 4 0 20)


messageSequence i =
    [ firstMessage i, editMessage i ] ++ (List.range 1 3 |> List.map (\j -> followingMessage (i + j))) ++ [ attachmentsMessage ]


firstMessage n =
    messageRow MessageRow
        (column None
            []
            [ row None
                [ spacing 10, paddingBottom 5 ]
                [ el MessageUsername [] (text "Message title")
                , el MessageTime [] (text "08:00am")
                ]
            , message n
            ]
            |> avatarGutter
        )


followingMessage n =
    messageRow MessageRow
        (el None
            [ paddingTop 6, width <| fill 1 ]
            (message n)
        )


editMessage n =
    messageRow EditMessageRow
        (el EditMessage
            [ width <| fill 1 ]
            (textArea TextArea [ width <| fill 1 ] "some blasphemous tomfoolery")
            |> avatarGutter
        )


attachmentsMessage =
    messageRow MessageRow
        (messageAttachments "https://i.guim.co.uk/img/media/1e698be526bf7a2288256d859f95690e5db3599a/2_0_1300_780/master/1300.png?w=1200&h=630&q=55&auto=format&usm=12&fit=crop&crop=faces%2Centropy&bm=normal&ba=bottom%2Cleft&blend64=aHR0cHM6Ly91cGxvYWRzLmd1aW0uY28udWsvMjAxNi8wNS8yNS9vdmVybGF5LWxvZ28tMTIwMC05MF9vcHQucG5n&s=ad2c97aeca6410e9ebfd095ece4f1a8e")


avatarGutter =
    onLeft [ el None [ alignLeft, paddingRight 10 ] avatar ]


messageRow style body =
    el style
        [ width <| fill 1
        , paddingLeft 60
        , paddingRight 45
        , paddingTop 10
        , paddingBottom 20
        , spacing 10
        , alignTop
        , attribute "data-class" "flex-fix"
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
         , attribute "data-class" "flex-fix"
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

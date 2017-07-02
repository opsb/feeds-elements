module Styles exposing (Styles(..), Variations(..), stylesheet)

import Color exposing (Color, rgba)
import Color.Convert
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font
import Style.Shadow as Shadow
import Utils exposing ((=>))


type Styles
    = None
    | AttachmentSummary
    | AttachmentTitle
    | Avatar
    | Chat
    | Container
    | ConversationCard
    | ConversationCardResponsesCount
    | ConversationCardTitle
    | ConversationOverview
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
    | Nav
    | Navbar
    | NavLink
    | Paper
    | SideBar
    | SideBarTitle
    | Link
    | TextArea
    | SideBarMenuTrigger
    | DropdownMenu
    | DropdownTrigger
    | DropdownMenuItem
    | DropdownMenuIcon
    | EditMenuItem
    | ScreenCover
    | Icon


type Variations
    = Active



--type Icon
--    = ShowMoreVertical
--    | Pencil1
--    | EcoThrowTrash
--iconStyles =
--    List.map iconStyle icons
--iconStyle : ( Icon, String ) -> Style Styles variation
--iconStyle ( tag, content ) =
--    style (Icon tag)
--        [ Font.typeface [ "nova" ]
--        , Color.background Color.charcoal
--        , Color.text colors.mediumGrey
--        , prop "border-radius" "50%"
--        , pseudo ":before"
--            [ prop "content" content
--            ]
--        ]


icons =
    { showMoreVertical = "'\\ebb9'"
    , pencil1 = "'\\e90e'"
    , ecoThrowTrash = "'\\f3d8'"
    }


hex : String -> Color
hex hexValue =
    case Color.Convert.hexToColor hexValue of
        Ok color ->
            color

        Err error ->
            Debug.crash error


colors =
    { darken1 = rgba 0 0 0 0.15
    , darken2 = rgba 0 0 0 0.25
    , darken3 = rgba 33 33 33 0.15
    , darkGrey = rgba 33 33 33 1
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


shadows : { box : Shadow, insetBottom : Shadow, insetTop : Shadow, deepBox : Shadow }
shadows =
    { insetTop =
        Shadow.inset
            { offset = ( 0, 6 )
            , size = -6
            , blur = 5
            , color = colors.darken3
            }
    , insetBottom =
        Shadow.inset
            { offset = ( 0, -6 )
            , size = -6
            , blur = 5
            , color = colors.darken3
            }
    , box =
        Shadow.box
            { offset = ( 0, 1 )
            , size = 0
            , blur = 4
            , color = colors.transparentGrey
            }
    , deepBox =
        Shadow.box
            { offset = ( 0, 2 )
            , size = 0
            , blur = 8
            , color = colors.darken1
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
                [ Color.background colors.darken1
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
        , style SideBarMenuTrigger
            [ Color.background Color.charcoal
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
            , Color.text colors.darkGrey
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
            [ Style.shadows [ shadows.box ]
            ]
        , style DiscussionHeader
            [ Color.background Color.white
            , Border.bottom 1
            , Border.solid
            , Color.border colors.veryLightGrey
            , hover
                [ cursor "pointer"
                ]
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
            , hover
                [ Color.background colors.lightestGrey
                ]
            ]
        , style ConversationCard
            [ Color.background Color.white
            , Style.shadows [ shadows.box ]
            , hover
                [ Color.background colors.lightestGrey
                , Style.cursor "pointer"
                , Style.shadows [ shadows.deepBox ]
                ]
            ]
        , style ConversationCardTitle
            [ Font.size 20
            , Font.weight 300
            , Color.text colors.darkGrey
            ]
        , style ConversationCardResponsesCount
            [ Font.size 12
            , Color.text colors.mediumGrey2
            ]
        , style Link
            [ hover
                [ cursor "pointer"
                ]
            ]
        , style DropdownMenu
            [ Color.background Color.white
            , Color.text colors.blue
            , Style.shadows [ shadows.box ]
            ]
        , style DropdownTrigger
            [ Color.background Color.charcoal
            , Color.text colors.mediumGrey
            , prop "border-radius" "50%"
            , iconStyle icons.showMoreVertical
            ]
        , style DropdownMenuItem
            [ hover
                [ Color.background colors.lightestGrey
                ]
            ]
        , style DropdownMenuIcon
            [ Color.text colors.mediumGrey
            ]
        , style EditMenuItem
            [ iconStyle icons.pencil1 ]
        , style ScreenCover
            [ Color.background <| Color.rgba 0 0 0 0 ]
        ]


iconStyle icon =
    pseudo ":before"
        [ Font.typeface [ "nova" ]
        , prop "content" icon
        ]

module Page.Conversation exposing (view)

import Element exposing (..)
import Element.Attributes exposing (..)
import Html.Attributes
import Markdown
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font
import Style.Shadow as Shadow
import Styles exposing (..)
import Utils exposing ((=>))
import View.Avatar as Avatar
import View.Image as Image


view =
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
    Avatar.avatarFrame DiscussionHeader
        []
        (el DiscussionHeaderTitle [ width <| fill 1 ] (text "Some title"))


scrollPane =
    column None
        [ yScrollbar, height <| fill 1 ]
        [ conversationAttachments "https://i.guim.co.uk/img/media/1e698be526bf7a2288256d859f95690e5db3599a/2_0_1300_780/master/1300.png?w=1200&h=630&q=55&auto=format&usm=12&fit=crop&crop=faces%2Centropy&bm=normal&ba=bottom%2Cleft&blend64=aHR0cHM6Ly91cGxvYWRzLmd1aW0uY28udWsvMjAxNi8wNS8yNS9vdmVybGF5LWxvZ28tMTIwMC05MF9vcHQucG5n&s=ad2c97aeca6410e9ebfd095ece4f1a8e"
        , conversationAttachments "http://images.techhive.com/images/article/2017/05/digital-disruption_primary4-100720489-large.3x2.jpg"
        , conversationAttachments "http://d1ri6y1vinkzt0.cloudfront.net/media/images/Medium/4c77e705-14c2-4aaa-bf28-25ca5bf89937.jpg?v=-8298800"
        , discussionDay "Day one"
        , discussionDay "Day two"
        ]


conversationAttachments imageSrc =
    row ConversationOverview
        [ attribute "data-class" "flex-fix", padding 20, spacing 20 ]
        [ el None [ inlineStyle [ "max-width" => "75%", "max-height" => "275px" ] ] (Image.proportional imageSrc)
        , attachmentSummary
        ]


messageAttachments imageSrc =
    row ConversationOverview
        [ attribute "data-class" "flex-fix", spacing 20 ]
        [ el None [ inlineStyle [ "max-width" => "50%" ] ] (Image.proportional imageSrc)
        , attachmentSummary
        ]


attachmentSummary =
    textLayout None
        [ spacing 10, inlineStyle [ "flex-shrink" => "10" ] ]
        [ el AttachmentTitle [] (text "'Unprecedented public stroke-fest': late-night hosts on Trump's cabinet meeting")
        , paragraph AttachmentSummary [] [ text "Comics, including Stephen Colbert, Trevor Noah and Seth Meyers, took aim at the president’s bizarre inaugural cabinet meeting on Monday" ]
        ]


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
    onLeft [ el None [ alignLeft, paddingRight 10 ] Avatar.avatar ]


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
    Avatar.avatarFrame MessageBox
        []
        (textArea TextArea
            [ width <| fill 1
            , placeholder "Wisdom, thoughts or just words..."
            ]
            "Some text"
        )



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

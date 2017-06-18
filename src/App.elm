module App exposing (..)

import Color exposing (Color, rgba)
import Color.Convert
import Element exposing (..)
import Element.Attributes exposing (..)
import Html
import Html.Attributes
import Markdown
import Navigation exposing (Location)
import Page.Conversation
import Page.Feed
import Page.Frame
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font
import Style.Shadow as Shadow
import Styles exposing (..)


(=>) a b =
    ( a, b )


type Page
    = Feed
    | Conversation
    | NotFound


type Msg
    = NavigateTo Page


type alias Model =
    { page : Page
    }


main : Program Never Model Msg
main =
    Navigation.program (pageFromLocation >> NavigateTo)
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


init : Location -> ( Model, Cmd Msg )
init =
    pageFromLocation >> (\page -> ( { page = page }, Cmd.none ))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NavigateTo page ->
            setPage page model


pageFromLocation location =
    case location.hash of
        "#feed" ->
            Feed

        "#conversation" ->
            Conversation

        "" ->
            Feed

        _ ->
            NotFound


setPage : Page -> Model -> ( Model, Cmd Msg )
setPage page model =
    ( { model | page = page }, Cmd.none )


view : Model -> Html.Html Msg
view model =
    Element.viewport Styles.stylesheet <|
        case model.page of
            Feed ->
                Page.Frame.view <|
                    Page.Feed.view

            Conversation ->
                Page.Frame.view <|
                    Page.Conversation.view

            NotFound ->
                Page.Frame.view <|
                    el None [] (text "not found")

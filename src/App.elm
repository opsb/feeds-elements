module App exposing (..)

import Color exposing (Color, rgba)
import Color.Convert
import DefaultDict exposing (DefaultDict)
import Dict exposing (Dict)
import Element exposing (..)
import Element.Attributes exposing (..)
import Html
import Html.Attributes
import Markdown
import Msg exposing (..)
import Navigation exposing (Location)
import Page.Conversation
import Page.Feed
import Page.Frame
import Route exposing (Route)
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font
import Style.Shadow as Shadow
import Styles exposing (..)


(=>) a b =
    ( a, b )


type alias Model =
    { route : Route
    , menus : DefaultDict String Bool
    }


main : Program Never Model Msg
main =
    Navigation.program (Route.fromLocation >> SetRoute)
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


init : Location -> ( Model, Cmd Msg )
init location =
    ( { route = Route.fromLocation location, menus = DefaultDict.empty False }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "update" msg of
        NavigateTo route ->
            ( model, Navigation.newUrl (Route.toUrl route) )

        SetRoute route ->
            setRoute route model

        ToggleMenu key ->
            ( { model | menus = DefaultDict.update key (not >> Just) model.menus }, Cmd.none )

        MouseClick _ ->
            ( resetMenus model, Cmd.none )


resetMenus model =
    { model | menus = DefaultDict.empty False }


setRoute : Route -> Model -> ( Model, Cmd Msg )
setRoute route model =
    ( { model | route = route }, Cmd.none )


view : Model -> Html.Html Msg
view model =
    Element.viewport Styles.stylesheet <|
        case model.route of
            Route.Feed ->
                Page.Frame.view model <|
                    Page.Feed.view

            Route.Conversation ->
                Page.Frame.view model <|
                    Page.Conversation.view

            Route.NotFound ->
                Page.Frame.view model <|
                    el None [] (text "not found")

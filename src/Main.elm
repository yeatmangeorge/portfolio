module Main exposing (main)

import Browser
import Browser.Navigation as Navigation
import Html exposing (Html, div, text)
import Html.Events exposing (onClick)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


links : { linkedin : String }
links =
    { linkedin = "https://www.linkedin.com/in/george-yeatman-0a35bb132/"
    }


type alias Model =
    { count : Int
    }


init : flags -> ( Model, Cmd Msg )
init _ =
    ( { count = 0 }
    , Cmd.none
    )


type Msg
    = OpenLinkedIn


type Topic
    = LinkedIn


topicToString : Topic -> String
topicToString topic =
    case topic of
        LinkedIn ->
            "LinkedIn"


topicActionMsg : Topic -> Msg
topicActionMsg topic =
    case topic of
        LinkedIn ->
            OpenLinkedIn


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OpenLinkedIn ->
            ( model
            , Navigation.load links.linkedin
            )


displayTopics : List Topic
displayTopics =
    [ LinkedIn ]


topicDiv : Topic -> Html Msg
topicDiv topic =
    div
        [ onClick (topicActionMsg topic) ]
        [ text (topicToString topic) ]


view : Model -> Html Msg
view model =
    div []
        (List.map topicDiv displayTopics)

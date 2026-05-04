module Main exposing (main)

import Browser
import Browser.Navigation as Navigation
import Html exposing (Html, div, text)
import Html.Attributes exposing (attribute)
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
        [ card, clickableCard, onClick (topicActionMsg topic) ]
        [ text (topicToString topic) ]


cssClass : String -> Html.Attribute msg
cssClass name =
    attribute "class" name


card : Html.Attribute msg
card =
    cssClass "card"


clickableCard : Html.Attribute msg
clickableCard =
    cssClass "card--clickable"


page : Html.Attribute msg
page =
    cssClass "page"


heading : Html.Attribute msg
heading =
    cssClass "heading"


title : Html.Attribute msg
title =
    cssClass "title"


contact : Html.Attribute msg
contact =
    cssClass "contact"


contentDivider : Html.Attribute msg
contentDivider =
    cssClass "content-divider"


contentDividerLarge : Html.Attribute msg
contentDividerLarge =
    cssClass "content-divider-large"


view : Model -> Html Msg
view model =
    div [ page ]
        ([ div [ contentDivider ] []
         , div [ card ]
            [ div [ heading ] [ text "George Yeatman" ]
            , div [ title ] [ text "Software Developer" ]
            , div [ contentDivider ] []
            , div [ contact ] [ text "yeatmangeorge@gmail.com" ]
            ]
         , div [ contentDividerLarge ] []
         ]
            ++ List.map topicDiv displayTopics
        )

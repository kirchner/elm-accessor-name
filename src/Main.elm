module Main exposing (main)

import Accessor
import Html exposing (Html)


main : Html msg
main =
    let
        print string =
            Html.div []
                [ string
                    |> Maybe.withDefault "not an accessor"
                    |> Html.text
                ]
    in
    [ Accessor.name accessor
        |> print
    , Accessor.name nestedAccessor
        |> print
    , Accessor.name noAccessor
        |> print
    , Accessor.name ((\_ -> \args -> args.counter) ())
        |> print
    , Accessor.name toString
        |> print
    ]
        |> Html.div []


accessor : { count : Int } -> Int
accessor args =
    args.count


nestedAccessor : { user : { name : String } } -> String
nestedAccessor =
    .user >> .name


noAccessor : Int -> String
noAccessor int =
    toString int

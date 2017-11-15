module Accessor exposing (name)

import Native.Function
import Regex exposing (..)


name : (a -> b) -> Maybe String
name accessor =
    let
        toMaybe text =
            if text == "" then
                Nothing
            else
                Just text
    in
    Native.Function.print accessor
        |> find All (regex "function\\s*\\(\\w+\\)\\s*{\\s*return\\s*\\w+\\.(\\w+);\\s*}")
        |> List.filterMap
            (\match ->
                case match.submatches of
                    (Just submatch) :: [] ->
                        Just submatch

                    _ ->
                        Nothing
            )
        |> List.reverse
        |> String.join "."
        |> toMaybe

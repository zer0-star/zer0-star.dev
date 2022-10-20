module Main where

import Prelude

import Data.Foldable (traverse_)
import Data.Tuple.Nested ((/\))
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Jelly.Aff (awaitBody)
import Jelly.Data.Component (Component, el, el', voidEl, text, textSig)
import Jelly.Data.Hooks (hooks)
import Jelly.Data.Prop (on, (:=))
import Jelly.Data.Signal (patch_, signal)
import Jelly.Mount (mount_)
import Web.HTML.Event.EventTypes (click)

type Context :: Row Type
type Context = ()

main :: Effect Unit
main = launchAff_ do
  appMaybe <- awaitBody
  liftEffect $ traverse_ (mount_ {} root) appMaybe

root :: Component Context
root = el' "div" do
  text "Hello!"

  voidEl "img" [ "src" := "./img/zer0-star.webp", "alt" := "zer0-star", "class" := "rounded-full animate-pop-out" ]

  counter

counter :: Component Context
counter = hooks do
  numSig /\ numAtom <- signal 0

  let
    button f str = el "button" [ "class" := "rounded-l shadow-lg mx-4 p-4", on click \_ -> patch_ numAtom f ] $ text str

  pure $ el "div" [ "class" := "flex flex-col" ] do
    el "div" [ "class" := "flex" ] do
      button (_ + 1) "Increment"
      button (_ - 1) "Decrement"
    textSig $ show <$> numSig

module Main where

import Prelude

import Data.Foldable (traverse_)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Jelly.Aff (awaitBody)
import Jelly.Data.Component (Component, el', voidEl, text)
import Jelly.Data.Prop ((:=))
import Jelly.Mount (mount_)

type Context :: Row Type
type Context = ()

main :: Effect Unit
main = launchAff_ do
  appMaybe <- awaitBody
  liftEffect $ traverse_ (mount_ {} root) appMaybe

bodyComponent :: Component Context
bodyComponent = do
  el' "h1" do
    text "Hello World!"

root :: Component Context
root = el' "div" do
  text "Hello!"

  voidEl "img" [ "src" := "./img/zer0-star.webp", "alt" := "zer0-star", "class" := "rounded-full animate-pop-out" ]

  bodyComponent

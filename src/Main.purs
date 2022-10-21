module Main where

import Prelude

import Data.Foldable (traverse_)
import Data.Tuple.Nested ((/\))
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Jelly.Aff (awaitBody)
import Jelly.Data.Component (Component, el, el', signalC, text, textSig, voidEl)
import Jelly.Data.Hooks (hooks)
import Jelly.Data.Prop (on, (:=))
import Jelly.Data.Signal (patch_, signal, get)
import Jelly.Mount (mount_)
import Jelly.Router.Components (routerLink, routerLink')
import Jelly.Router.Data.Router (RouterContext, newRouter, provideRouterContext, useRouter)
import Web.HTML.Event.EventTypes (click)

type Context :: Row Type
type Context = ()

main :: Effect Unit
main = launchAff_ do
  appMaybe <- awaitBody
  router <- newRouter [] pure
  liftEffect $ traverse_ (mount_ (provideRouterContext router {}) root) appMaybe

root :: Component (RouterContext Context)
root = do
  el "div" [ "class" := "flex flex-row" ] do
    el "div" [ "class" := "h-full w-fit" ] do
      routerLink { path: [], query: mempty, hash: "" } [ "class" := "block p-2" ] (text "Home")
      routerLink { path: [ "counter" ], query: mempty, hash: "" } [ "class" := "block p-2" ] (text "Counter")
      routerLink { path: [ "hello", "World" ], query: mempty, hash: "" } [ "class" := "block p-2" ] (text "Greet")
      routerLink { path: [ "nanachi" ], query: mempty, hash: "" } [ "class" := "block p-2" ] (text "???")
    el "div" [ "class" := "h-full w-[1px] bg-slate-300 bg-opacity-50 hidden lg:block" ] mempty
    page

page :: Component (RouterContext Context)
page = hooks do
  { currentUrlSig } <- useRouter
  pure $ signalC do
    url <- currentUrlSig
    pure case url.path of
      [] -> top
      [ "counter" ] -> counter
      [ "hello", name ] -> hello name
      _ -> notFound

top :: Component (RouterContext Context)
top = el' "div" do
  text "Hello!"

  voidEl "img" [ "src" := "./img/zer0-star.webp", "alt" := "zer0-star", "class" := "h-64 rounded-full animate-pop-out" ]

counter :: Component (RouterContext Context)
counter = hooks do
  numSig /\ numAtom <- signal 0

  let
    button f str = el "button" [ "class" := "rounded-l shadow-lg mx-4 p-4", on click \_ -> patch_ numAtom f ] $ text str

  pure $ el "div" [ "class" := "flex flex-col" ] do
    el "div" [ "class" := "flex" ] do
      button (_ + 1) "Increment"
      button (_ - 1) "Decrement"
    textSig $ show <$> numSig

hello :: String -> Component (RouterContext Context)
hello str = text $ "Hello, " <> str <> "!"

notFound :: Component (RouterContext Context)
notFound = text "404"
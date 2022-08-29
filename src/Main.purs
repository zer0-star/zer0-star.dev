module Main where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Console (log)
import Hooks.UseClass (useClass)
import Hooks.UseDelayClass (useDelayClass)
import Jelly (Component, ch, el, launchApp, text, (:=))

import Web.HTML (window)
import Web.HTML.HTMLDocument (body)
import Web.HTML.Window (document)

main :: Effect Unit
main = do
  log "awoo"

  launchApp root unit

  bm <- body =<< document =<< window

  case bm of
    Just b -> log "yes!"
    Nothing -> log "no!"

root :: Component Unit
root = el "div" do
  "id" := pure "root"

  useClass $ pure "w-screen min-w-[22rem]"

  ch $ text $ pure "Hello!"

  ch $ el "img" do
    useClass $ pure "rounded-full transition duration-1000 ease-out"
    useDelayClass 400 (pure "rotate-[540deg] scale-0") (pure "")
    "src" := pure "./img/zer0-star.webp"
    "alt" := pure "zer0-star"

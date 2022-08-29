module Main where

import Prelude

import Effect (Effect)
import Hooks.UseClass (useClass)
import Hooks.UseDelayClass (useDelayClass)
import Jelly (Component, ch, el, launchApp, (:=))

main :: Effect Unit
main = do
  launchApp root unit

root :: Component Unit
root = el "div" do
  ch $ el "img" do
    useClass $ pure "transition duration-1000 ease-out"
    useDelayClass 400 (pure "rotate-[540deg] scale-0") (pure "")
    "src" := pure "./img/zer0-star.webp"
    "alt" := pure "zer0-star"

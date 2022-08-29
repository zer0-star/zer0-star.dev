module Main where

import Prelude

import Effect (Effect)
import Hooks.UseClass (useClass)
import Hooks.UseDelayClass (useDelayClass)
import Jelly (Component, ch, el, launchApp, text, (:=))

main :: Effect Unit
main = do
  launchApp root unit

root :: Component Unit
root = el "div" do
  "id" := pure "root"

  useClass $ pure "w-screen min-w-[22rem]"

  ch $ text $ pure "Hello!"

  ch $ el "img" do
    useClass $ pure "rounded-full transition duration-1000 ease-out"
    useDelayClass 100 (pure "rotate-[540deg] scale-0") (pure "")
    "src" := pure "./img/zer0-star.webp"
    "alt" := pure "zer0-star"

module BrowserMain where

import Prelude

import Data.Color (defaultColor)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Jelly (awaitDocument, hydrate_)
import Jelly.Router.Data.Router (newRouter, provideRouter)
import Root (rootComponent)

main :: Effect Unit
main = launchAff_ do
  d <- awaitDocument
  router <- newRouter [] pure
  liftEffect $ hydrate_ (provideRouter router { color: defaultColor }) rootComponent d

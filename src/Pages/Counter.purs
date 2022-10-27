module Pages.Counter where

import Prelude

import Data.Tuple.Nested ((/\))
import Jelly (Component, hooks, on, text, textSig, (:=))
import Jelly.Data.Signal (modifyAtom_, newState)
import Jelly.Element as JE
import Web.HTML.Event.EventTypes (click)

counterPage :: forall context. Component context
counterPage = hooks do
  numSig /\ numAtom <- newState 0

  let
    button f str = JE.button [ "class" := "rounded-l shadow-lg mx-4 p-4", on click \_ -> modifyAtom_ numAtom f ] $ text str

  pure $ JE.div [ "class" := "flex flex-col" ] do
    JE.div [ "class" := "flex" ] do
      button (_ + 1) "Increment"
      button (_ - 1) "Decrement"
    textSig $ show <$> numSig
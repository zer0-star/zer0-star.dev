module Pages.Works where

import Prelude

import Jelly (Component, text)
import Component.Markup as M

worksPage :: forall context. Component context
worksPage = do
  M.h1 $ text "Works"
  text "WIP; check back later!"
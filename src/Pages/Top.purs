module Pages.Top where

import Prelude

import Jelly (Component, text, (:=))
import Jelly.Element as JE

topPage :: forall context. Component context
topPage = do
  text "Hello!!"
  JE.img [ "src" := "./img/zer0-star.webp", "alt" := "zer0-star", "class" := "h-64 rounded-full animate-pop-out" ]

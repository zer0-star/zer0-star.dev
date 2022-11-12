module Component.Markup where

import Prelude

import Data.Array (fold)
import Jelly (Component, (:=))
import Jelly.Element as JE

h1 :: forall context. Component context -> Component context
h1 = JE.h1 [ "class" := "font-Quicksand font-light text-5xl tracking-tightest before:content-['#'] before:mr-1 before:text-3xl before:tracking-tight" ]

h2 :: forall context. Component context -> Component context
h2 = JE.h2 [ "class" := "font-Quicksand font-light text-4xl tracking-tightest before:content-['##'] before:mr-1 before:text-2xl before:tracking-tight" ]

list :: forall context. Array (Component context) -> Component context
list items = JE.ul [ "class" := "pl-4" ] $ fold (map renderListItem items)
  where
  renderListItem item = JE.li [ "class" := "marker:content-['-_']" ] item

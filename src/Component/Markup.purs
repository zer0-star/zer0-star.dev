module Component.Markup where

import Prelude

import Data.Array (fold)
import Jelly (Component, (:=))
import Jelly.Element as JE

h1 :: forall context. Component context -> Component context
h1 = JE.h1 [ "class" := "underline decoration-2 font-Quicksand font-light text-6xl tracking-tightest my-8 before:content-['#'] before:mr-1 before:text-4xl before:tracking-tight before:inline-block" ]

h2 :: forall context. Component context -> Component context
h2 = JE.h2 [ "class" := "font-Quicksand font-light text-5xl tracking-tightest my-4 before:content-['##'] before:mr-1 before:text-3xl before:tracking-tight" ]

h3 :: forall context. Component context -> Component context
h3 = JE.h3 [ "class" := "font-Quicksand font-light text-4xl tracking-tightest my-4 before:content-['###'] before:mr-1 before:text-2xl before:tracking-tight" ]

h4 :: forall context. Component context -> Component context
h4 = JE.h4 [ "class" := "font-Quicksand font-light text-4xl tracking-tightest my-4 before:content-['####'] before:mr-1 before:text-2xl before:tracking-tight" ]

list :: forall context. Array (Component context) -> Component context
list items = JE.ul [ "class" := "pl-4" ] $ fold (map renderListItem items)
  where
  renderListItem item = JE.li [ "class" := "marker:content-['-_']" ] item

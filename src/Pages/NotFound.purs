module Pages.NotFound where

import Prelude

import Jelly (Component, text)

notFoundPage :: forall context. Component context
notFoundPage = text "404"
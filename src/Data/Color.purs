module Data.Color where

import Prelude

import Jelly.Data.Hooks (Hooks)
import Jelly.Hooks.UseContext (useContext)

type Color = { textColor :: String, bgColor :: String }

type ColorContext ctx = (color :: Color | ctx)

defaultColor :: Color
defaultColor =
  { textColor: "text-pale-blue"
  , bgColor: "bg-midnight-blue"
  }

useColor :: forall context. Hooks (ColorContext context) Color
useColor = _.color <$> useContext
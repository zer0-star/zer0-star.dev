module Context where

import Prelude

import Data.Color (ColorContext)
import Jelly.Router.Data.Router (RouterContext)
import Type.Row (type (+))

type Context = RouterContext + ColorContext + ()

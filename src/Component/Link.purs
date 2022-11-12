module Component.Link where

import Context (Context)
import Data.Page (Page, pageToUrl)
import Jelly (Component, (:=))
import Jelly.Router.Components (routerLink)

linkToPage :: Page -> Component Context -> Component Context
linkToPage page = routerLink (pageToUrl page) [ "class" := "underline decoration-indigo-500 font-bold" ]


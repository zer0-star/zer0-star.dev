module Component.Link where

import Context (Context)
import Data.Page (Page, pageToUrl)
import Jelly (Component, (:=))
import Jelly.Element as JE
import Jelly.Router.Components (routerLink)

linkPage :: Page -> Component Context -> Component Context
linkPage page = routerLink (pageToUrl page) [ "class" := "underline decoration-indigo-500 font-bold" ]

link :: forall context. String -> Component context -> Component context
link url = JE.a [ "href" := url, "class" := "underline decoration-emerald-500 font-bold", "target" := "_blank", "rel" := "noreferrer noopener" ]
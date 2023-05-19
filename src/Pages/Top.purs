module Pages.Top where

import Prelude

import Component.Link (linkPage)
import Component.Markup as M
import Context (Context)
import Data.Page (Page(..), pageToUrl)
import Jelly (Component, text, (:=))
import Jelly.Element as JE
import Jelly.Router.Components (routerLink)

topPage :: Component Context
topPage = do
  JE.div [ "class" := "flex flex-row gap-2 items-center divide-x-2 divide-pale-blue my-auto" ] do
    JE.img [ "src" := "/img/zer0-star.svg", "height" := "240", "width" := "240", "alt" := "zer0-star", "class" := "h-60" ]
    JE.div [ "class" := "flex flex-col gap-20 text-6xl py-16" ] do
      navLink PageAbout "About Me"
      navLink PageWorks "Works"

navLink :: Page -> String -> Component Context
navLink page str = routerLink (pageToUrl page) [ "class" := "font-Quicksand font-light text-8xl tracking-tightest" ] $ text str

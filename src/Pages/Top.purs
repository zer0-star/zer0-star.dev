module Pages.Top where

import Prelude

import Component.Link (linkPage)
import Component.Markup as M
import Context (Context)
import Data.Page (Page(..), pageToUrl)
import Jelly (Component, hooks, on, text, (:=))
import Jelly.Element as JE
import Jelly.Router (urlToString, useRouter)
import Jelly.Router.Components (routerLink)
import Utils.Transition (useTransition)
import Web.Event.Event (preventDefault)
import Web.HTML.Event.EventTypes (click)

topPage :: Component Context
topPage = do
  JE.div [ "class" := "h-2/3 flex flex-row gap-0 items-center my-auto" ] do
    JE.div [ "class" := "contain-paint px-2" ] do
      JE.img [ "src" := "/img/zer0-star.svg", "height" := "240", "width" := "240", "alt" := "zer0-star", "class" := "h-60 animate-top-left" ]
    JE.div [ "class" := "h-[400px] w-[2px] bg-pale-blue animate-top-line origin-top" ] mempty
    JE.div [ "class" := "flex flex-col gap-20 text-6xl animate-top-right contain-paint px-2" ] do
      JE.div [ "class" := "animate-top-right-1 view-transition-about-me w-fit" ] do
        navLink PageAbout "About Me"
      JE.div [ "class" := "animate-top-right-2 view-transition-works w-fit" ] do
        navLink PageWorks "Works"

navLink :: Page -> String -> Component Context
navLink page str = hooks do
  { pushUrl, basePath } <- useRouter
  let
    url = pageToUrl page
    handleClick e = do
      preventDefault e
      useTransition do
        pushUrl url
  pure $ JE.a [ on click handleClick, "href" := urlToString basePath url, "class" := "font-Quicksand font-light text-8xl tracking-tightest block" ] $ text str

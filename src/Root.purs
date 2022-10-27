module Root where

import Prelude

import Context (Context)
import Data.Color (useColor)
import Data.Page (Page(..), urlToPage)
import Jelly (Component, doctypeHtml, hooks, signalC, text, (:=))
import Jelly.Element as JE
import Jelly.Router.Components (routerLink)
import Jelly.Router.Data.Router (useRouter)
import Pages.Counter (counterPage)
import Pages.NotFound (notFoundPage)
import Pages.Top (topPage)

rootComponent :: Component Context
rootComponent = do
  doctypeHtml
  JE.html [ "lang" := "en", "class" := "font-Oxygen" ] do
    headComponent
    bodyComponent

headComponent :: Component Context
headComponent = JE.head' do
  JE.title' $ text "zer0-star's page"
  JE.script [ "src" := "/index.js" ] mempty
  JE.link [ "rel" := "stylesheet", "href" := "/index.css" ]

  JE.link [ "rel" := "preconnect", "href" := "https://fonts.googleapis.com" ]
  JE.link [ "rel" := "preconnect", "href" := "https://fonts.gstatic.com", "crossorigin" := true ]
  JE.link [ "rel" := "stylesheet", "href" := "https://fonts.googleapis.com/css2?family=Oxygen:wght@400;700&display=swap" ]

bodyComponent :: Component Context
bodyComponent = hooks do
  { textColor, bgColor } <- useColor
  pure do
    JE.body [ "class" := "flex flex-row h-screen w-screen " <> bgColor <> " " <> textColor ] do
      JE.div [ "class" := "h-full w-fit" ] do
        routerLink { path: [], query: mempty, hash: "" } [ "class" := "block p-2" ] (text "Home")
        routerLink { path: [ "counter" ], query: mempty, hash: "" } [ "class" := "block p-2" ] (text "Counter")
        routerLink { path: [ "hello", "World" ], query: mempty, hash: "" } [ "class" := "block p-2" ] (text "Greet")
        routerLink { path: [ "nanachi" ], query: mempty, hash: "" } [ "class" := "block p-2" ] (text "???")
      JE.div [ "class" := "h-full w-[1px] bg-slate-300 bg-opacity-50 hidden lg:block" ] mempty
      JE.div [ "class" := "m-2" ] do
        mainContent

mainContent :: Component Context
mainContent = hooks do
  { currentUrlSig } <- useRouter
  pure $ JE.main' $ signalC do
    currentUrl <- currentUrlSig
    pure case urlToPage currentUrl of
      PageTop -> topPage
      PageCounter -> counterPage
      PageNotFound -> notFoundPage

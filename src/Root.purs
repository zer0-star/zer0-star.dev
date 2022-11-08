module Root where

import Prelude

import Context (Context)
import Data.Color (useColor)
import Data.Page (Page(..), urlToPage)
import Jelly (Component, doctypeHtml, hooks, signalC, text, (:=))
import Jelly.Element as JE
import Jelly.Router (routerLink')
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
  JE.link [ "rel" := "stylesheet", "href" := "https://fonts.googleapis.com/css2?family=Oxygen:wght@400;700&family=Quicksand:wght@300&display=swap" ]

bodyComponent :: Component Context
bodyComponent = hooks do
  { textColor, bgColor } <- useColor
  pure do
    JE.body [ "class" := bgColor <> " " <> textColor ] do
      JE.header [ "class" := "sticky top-0" <> " " <> bgColor ] do
        JE.div [ "class" := "mx-4 my-1" ] do
          JE.div [ "class" := "font-Quicksand font-light text-6xl tracking-tightest" ] do
            routerLink' { path: [], query: mempty, hash: "" } $ text "zer0-star's Homepage"
          JE.div [ "class" := "flex gap-4 h-full w-64 underline decoration-indigo-500 font-bold text-xl ml-1" ] do
            routerLink { path: [], query: mempty, hash: "" } [ "class" := "block" ] (text "Home")
            routerLink { path: [ "counter" ], query: mempty, hash: "" } [ "class" := "block" ] (text "Counter")
            routerLink { path: [ "hello", "World" ], query: mempty, hash: "" } [ "class" := "block" ] (text "Greet")
            routerLink { path: [ "nanachi" ], query: mempty, hash: "" } [ "class" := "block" ] (text "???")
        JE.div [ "class" := "h-[1px] w-full bg-pale-blue" ] mempty
      JE.div [ "class" := "p-2 h-full w-full grow" ] do
        mainContent

mainContent :: Component Context
mainContent = hooks do
  { currentUrlSig } <- useRouter
  pure $ JE.main [ "class" := "h-full w-full" ] $ signalC do
    currentUrl <- currentUrlSig
    pure case urlToPage currentUrl of
      PageTop -> topPage
      PageCounter -> counterPage
      PageNotFound -> notFoundPage

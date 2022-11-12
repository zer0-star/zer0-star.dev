module Root where

import Prelude

import Component.Link (linkToPage)
import Context (Context)
import Data.Color (useColor)
import Data.Page (Page(..), urlToPage)
import Jelly (Component, doctypeHtml, hooks, signalC, text, (:=))
import Jelly.Element as JE
import Jelly.Router (routerLink')
import Jelly.Router.Data.Router (useRouter)
import Pages.NotFound (notFoundPage)
import Pages.Top (topPage)
import Pages.Works (worksPage)

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
    JE.body [ "class" := [ bgColor, textColor ] ] do
      JE.header [ "class" := "sticky top-0" <> " " <> bgColor ] do
        JE.div [ "class" := "px-4 py-1" ] do
          JE.div [ "class" := "font-Quicksand font-light text-6xl tracking-supertight" ] do
            routerLink' { path: [], query: mempty, hash: "" } do
              text "zer0-star"
              JE.span [ "class" := "ml-1 mr-0.5" ] $ text "."
              text "dev"
          JE.div [ "class" := "flex gap-4 text-xl ml-1" ] do
            linkToPage PageTop (text "About")
            linkToPage PageWorks (text "Works")
        JE.div [ "class" := "h-[1px] w-full bg-pale-blue" ] mempty
      JE.div [ "class" := "p-2 h-full w-full grow" ] do
        mainContent

mainContent :: Component Context
mainContent = hooks do
  { currentUrlSig } <- useRouter
  pure $ JE.main [ "class" := "h-full w-full text-lg flex flex-col items-center" ] do
    JE.div [ "class" := "w-full max-w-3xl" ] $ signalC do
      currentUrl <- currentUrlSig
      pure case urlToPage currentUrl of
        PageTop -> topPage
        PageWorks -> worksPage
        PageNotFound -> notFoundPage

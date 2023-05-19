module Root where

import Prelude

import Component.Link (link, linkPage)
import Component.Markup as M
import Context (Context)
import Data.Color (useColor)
import Data.Page (Page(..), urlToPage)
import Jelly (Component, doctypeHtml, hooks, signalC, text, (:=))
import Jelly.Element as JE
import Jelly.Router (routerLink')
import Jelly.Router.Data.Router (useRouter)
import Pages.NotFound (notFoundPage)
import Pages.Top (topPage)
import Pages.About (aboutPage)
import Pages.Works (worksPage)

rootComponent :: Component Context
rootComponent = do
  doctypeHtml
  JE.html [ "lang" := "en", "class" := "font-Oxygen", "prefix" := "og: http://ogp.me/ns#" ] do
    headComponent
    bodyComponent

headComponent :: Component Context
headComponent = JE.head' do
  JE.title' $ text "zer0-star.dev"
  JE.script [ "src" := "/index.js" ] mempty
  JE.link [ "rel" := "stylesheet", "href" := "/index.css" ]

  JE.link [ "rel" := "preconnect", "href" := "https://fonts.googleapis.com" ]
  JE.link [ "rel" := "preconnect", "href" := "https://fonts.gstatic.com", "crossorigin" := true ]
  JE.link [ "rel" := "stylesheet", "href" := "https://fonts.googleapis.com/css2?family=Oxygen:wght@400;700&family=Quicksand:wght@300&display=swap" ]

  JE.meta [ "name" := "twitter:card", "content" := "summary_large_image" ]
  JE.meta [ "name" := "twitter:creator", "content" := "@0x_zer0star" ]

  JE.meta [ "property" := "og:url", "content" := "https://zer0-star.dev/" ]
  JE.meta [ "property" := "og:type", "content" := "website" ]
  JE.meta [ "property" := "og:title", "content" := "zer0-star.dev" ]
  JE.meta [ "property" := "og:description", "content" := "zer0-star's website" ]
  JE.meta [ "property" := "og:image", "content" := "https://zer0-star.dev/img/ogp_image.png" ]

  JE.link [ "rel" := "icon", "href" := "/favicon.svg", "type" := "image/svg+xml" ]

bodyComponent :: Component Context
bodyComponent = hooks do
  { textColor, bgColor } <- useColor
  pure do
    JE.body [ "class" := [ "min-h-screen flex flex-col", bgColor, textColor ] ] do
      headerComponent
      mainContent
      footerComponent

headerComponent :: Component Context
headerComponent = hooks do
  { bgColor } <- useColor
  pure do
    JE.header [ "class" := [ "sticky top-0", bgColor ] ] do
      JE.div [ "class" := "px-4 py-1" ] do
        JE.div [ "class" := "font-Quicksand font-light text-6xl tracking-supertight" ] do
          routerLink' { path: [], query: mempty, hash: "" } do
            text "zer0-star"
            JE.span [ "class" := "ml-1 mr-0.5" ] $ text "."
            text "dev"
        JE.div [ "class" := "flex gap-4 text-xl ml-1" ] do
          linkPage PageAbout (text "About Me")
          linkPage PageWorks (text "Works")
      JE.div [ "class" := "h-[1px] w-full bg-pale-blue" ] $ pure unit

footerComponent :: Component Context
footerComponent = do
  JE.footer [ "class" := "h-24 w-full" ] do
    JE.div [ "class" := "h-[1px] w-full bg-pale-blue" ] $ pure unit
    JE.div [ "class" := "flex flex-row justify-between p-8" ] do
      JE.div' do
        text "powered by "
        link "https://github.com/yukikurage/purescript-jelly" $ text "Jelly"
      JE.div' do
        text "&copy;2023 zer0-star"

mainContent :: Component Context
mainContent = hooks do
  { currentUrlSig } <- useRouter
  pure $ JE.main [ "class" := "p-2 flex-auto self-center w-full my-4 text-lg flex flex-col max-w-3xl" ] do
    signalC do
      currentUrl <- currentUrlSig
      pure case urlToPage currentUrl of
        PageTop -> topPage
        PageAbout -> aboutPage
        PageWorks -> worksPage
        PageNotFound -> notFoundPage

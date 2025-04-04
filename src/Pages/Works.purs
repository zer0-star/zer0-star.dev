module Pages.Works where

import Prelude

import Jelly (Component, text, (:=))
import Jelly.Element as JE
import Component.Link (link)
import Component.Markup as M

worksPage :: forall context. Component context
worksPage = do
  M.h1 $ JE.span [ "class" := "view-transition-works inline-block decoration-inherit" ] $ text "Works"
  M.h2 $ link "https://github.com/zer0-star/git-hs" $ normalText "git-hs"
  JE.p' $ text "A toy git implementetaion written in Haskell"
  JE.p' $ text "Not fully implemeted yet"
  M.h2 $ link "https://github.com/zer0-star/zer0-star.dev" $ normalText "zer0-star.dev"
  JE.p' $ text "This website"
  JE.p' do
    text "Written in PureScript with "
    link "https://github.com/yukikurage/purescript-jelly" $ text "Jelly"
  M.h2 $ link "https://github.com/zer0-star/nix-home" $ normalText "nix-home"
  JE.p' $ text "my home-manager setup"

normalText :: forall context. String -> Component context
normalText str = JE.span [ "class" := "font-normal" ] $ text str
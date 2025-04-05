module Pages.Works where

import Prelude

import Component.Link (link)
import Component.Markup as M
import Jelly (Component, text, (:=))
import Jelly.Element as JE

worksPage :: forall context. Component context
worksPage = do
  M.h1 $ JE.span [ "class" := "view-transition-works inline-block decoration-inherit" ] $ text "Works"

  M.h2 $ link "https://github.com/lapisla-prover/lapisla-prover" $ normalText "Lapisla"
  JE.p' $ text "A proof assistant, an ecosystem to distribute and reuse proofs, and a platform to share proofs with others"
  JE.p' $ text "It is focused on make formal proofs easy to write and share"
  JE.p' do
    text "deployed on "
    link "https://lapisla.net" $ text "lapisla.net"
  JE.p' do
    text "Blog post (Japanese): "
    link "https://trap.jp/post/2478/" $ text "冬ハッカソンで定理証明支援系 「lapisla-prover」(and more !) を開発しました！ | 東京科学大学デジタル創作同好会traP https://trap.jp/post/2478/"

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
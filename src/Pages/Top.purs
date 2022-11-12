module Pages.Top where

import Prelude

import Jelly (Component, text, (:=))
import Jelly.Element as JE

import Component.Markup as M

topPage :: forall context. Component context
topPage = JE.div [ "class" := "h-full w-full" ] do
  JE.div' do
    JE.img [ "src" := "./img/zer0-star.webp", "alt" := "zer0-star", "class" := "h-64 rounded-full animate-pop-out" ]
  M.h1 $ text "whoami"
  M.h2 $ text "Education"
  JE.p' $ text "School of Computing, Tokyo Institute of Technology"
  M.h2 $ text "Links"
  M.list
    [ account "Twitter" "0x_zer0star" "https://twitter.com/0x_zer0-star"
    , do
        account "Github" "zer0-star" "https://github.com/zer0-star"
        M.list
          [ do
              link "zer0-star/zer0-star.dev" "https://github.com/zer0-star/zer0-star.dev"
              JE.div' $ text "this website"
          , do
              link "zer0-star/nix-home" "https://github.com/zer0-star/nix-home"
              JE.div' $ text "my home-manager setup"
          ]
    , account "AtCoder" "zer0star" "https://atcoder.jp/users/zer0star"
    , link "Blog" "https://zer0-star.github.io/blog"
    ]

account :: forall context. String -> String -> String -> Component context
account name id url = do
  text (name <> ": ")
  JE.a [ "href" := url, "class" := "underline decoration-emerald-500 font-bold", "target" := "_blank", "rel" := "noreferrer noopener" ] $ text ("@" <> id)

link :: forall context. String -> String -> Component context
link name url = JE.a [ "href" := url, "class" := "underline decoration-emerald-500 font-bold", "target" := "_blank", "rel" := "noreferrer noopener" ] $ text name
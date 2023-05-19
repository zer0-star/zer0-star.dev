module Pages.About where

import Prelude

import Component.Link (link)
import Component.Markup as M
import Jelly (Component, text, (:=))
import Jelly.Element as JE

aboutPage :: forall context. Component context
aboutPage = do
  M.h1 $ text "About Me"
  JE.div [ "class" := "flex items-center" ] do
    JE.img [ "src" := "/img/zer0-star.svg", "height" := "80", "alt" := "zer0-star", "class" := "h-20 rounded-full" ]
    JE.div [ "class" := "ml-4" ] do
      JE.h2 [ "class" := "text-3xl font-bold" ] do
        text "zer0-star"
      JE.p [ "class" := "" ] do
        text "Software Engineer"
  M.h2 $ text "whoami"
  JE.p' $ text "I am:"
  M.list
    [ text "a competitive programmer"
    , do
        text "a member of "
        link "https://trap.jp/" $ text "traP"
    --     text " (short for Digital Creators Club traP)"
    , text "a student"
    , text "a programming language lover"
    ]
  M.h3 $ text "Education"
  JE.p' $ text "School of Computing, Tokyo Institute of Technology"
  M.h3 $ text "Links"
  M.list
    [ account "https://twitter.com/0x_zer0-star" "Twitter" "0x_zer0star"
    , account "https://keybase.io/zer0star" "Keybase" "zer0star"
    , account "https://github.com/zer0-star" "Github" "zer0-star"
    , account "https://atcoder.jp/users/zer0star" "AtCoder" "zer0star"
    , link "https://blog.zer0-star.dev/" $ text "Blog"
    ]
  M.h2 $ text "Skills"
  M.list
    [ do
        text "Competitive Programming"
        JE.div' $ text "Ratings:"
        M.list
          [ do
              text "AtCoder: 2110, yellow (at 2023/02/09)"
          ]
    ]
  M.h2 $ text "Favorites"
  M.h3 $ text "Programming Languages"
  M.list
    [ text "Nim"
    , text "Haskell"
    ]
  M.h3 $ text "Games"
  M.list
    [ do
        text "Puzzle games"
        M.list
          [ text "Puyo Puyo"
          , text "Tetris"
          ]
    , text "Super Smash Bros."
    , text "Splatoon 3"
    ]
  M.h3 $ text "Characters"
  M.list
    [ link "https://puyonexus.com/wiki/Feli" $ text "Feli"
    , link "https://madeinabyss.fandom.com/wiki/Nanachi" $ text "Nanachi"
    ]

account :: forall context. String -> String -> String -> Component context
account url name id = do
  text (name <> ": ")
  link url (text $ "@" <> id)
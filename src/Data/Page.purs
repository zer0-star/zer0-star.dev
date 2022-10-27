module Data.Page where

import Prelude

import Jelly.Router.Data.Url (Url)

data Page = PageNotFound | PageTop | PageCounter

derive instance Eq Page

pageToUrl :: Page -> Url
pageToUrl page =
  let
    path = case page of
      PageCounter -> [ "counter" ]
      PageNotFound -> [ "404" ]
      PageTop -> []
  in
    { path: path
    , query: mempty
    , hash: ""
    }

urlToPage :: Url -> Page
urlToPage url =
  case url.path of
    [] -> PageTop
    [ "counter" ] -> PageCounter
    _ -> PageNotFound
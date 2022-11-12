module Data.Page where

import Prelude

import Jelly.Router.Data.Url (Url)

data Page = PageNotFound | PageTop | PageWorks

derive instance Eq Page

pageToUrl :: Page -> Url
pageToUrl page =
  let
    path = case page of
      PageWorks -> [ "works" ]
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
    [ "works" ] -> PageWorks
    _ -> PageNotFound
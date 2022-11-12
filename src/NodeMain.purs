module NodeMain where

import Prelude

import Data.Color (defaultColor)
import Data.Page (Page(..), pageToUrl)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Jelly (render)
import Jelly.Router (makeRelativeFilePath, newMockRouter, provideRouter)
import Node.Encoding (Encoding(..))
import Node.FS.Aff (mkdir', writeTextFile)
import Node.FS.Perms (all, mkPerms)
import Root (rootComponent)

main :: Effect Unit
main = launchAff_ do
  let
    pageToOutDir page = [ "public" ] <> (pageToUrl page).path
    genHTML page dirname filename = do
      router <- liftEffect $ newMockRouter $ pageToUrl page
      let
        context = provideRouter router { color: defaultColor }
      rendered <- liftEffect $ render context rootComponent
      mkdir' (makeRelativeFilePath $ dirname) { mode: mkPerms all all all, recursive: true }
      writeTextFile UTF8 (makeRelativeFilePath $ dirname <> [ filename ]) rendered
    genHTML' page = genHTML page (pageToOutDir page)

  genHTML' PageTop "index.html"
  genHTML' PageWorks "index.html"
  genHTML PageNotFound [ "public" ] "404.html"
{-# LANGUAGE DeriveDataTypeable
        , ScopedTypeVariables         #-}

module Notes1  where

import Database.CouchDB (getDoc, newDoc, runCouchDB', db, Rev(..), Doc)
import Data.Data (Data, Typeable)

import Text.JSON
import Text.JSON.Pretty (pp_value)
import Text.JSON.Pretty (render)
import Text.JSON.Generic (toJSON, fromJSON)

import Text.Feed.Query
import Text.Feed.Import
import Text.Feed.Types( Item(RSSItem) )
import Text.RSS.Syntax
import Paths_feed

type Strings = [String]  -- basic

data Note = Note {title, text :: String, tags :: Strings}
    deriving (Eq, Ord, Show, Read , Typeable, Data)  -- not yet necessary

------ copied from henry laxon

ppJSON = putStrLn . render . pp_value

justDoc :: (Data a) => Maybe (Doc, Rev, JSValue) -> a
justDoc (Just (d,r,x)) = stripResult (fromJSON x)
  where stripResult (Ok z) = z
        stripResult (Error s) = error $ "JSON error " ++ s
justDoc Nothing = error "No such Document"

 --------------------------------
mynotes = db "firstnotes1"

n0 = Note "a59" "a1 text vv 45" ["tag1"]

n1 = Note "a56" "a1 text vv 45" ["tag1"]
n2 = Note "a56" "updated a1 text vv 45" ["tag1"]

n1j = toJSON n1  -- convNote2js n1

runNotes1 = do
            (doc1, rev1) <- runCouchDB' $ newDoc mynotes n1j
            putStrLn $ "stored note " ++ show doc1 ++ "  revision " ++ show rev1
            Just (_,_,jvalue) <- runCouchDB' $ getDoc mynotes doc1
            ppJSON jvalue

            jstuff <- runCouchDB' $ getDoc mynotes doc1
            let d = justDoc jstuff :: Note
            putStrLn $ "found " ++ show d
            return ()

loadFeed filePath = parseFeedFromFile =<< return filePath

firstItem feed = head $ getFeedItems feed

showFeed filePath = do
                    let ioFeed = parseFeedFromFile =<< return filePath
                    feed <- ioFeed
                    putStrLn $ "Title: " ++ show (getFeedTitle feed)
                    let items = getFeedItems feed
                    let item = items !! 0
                    putStrLn $ "Article Title: " ++ show (getItemTitle item)
                    putStrLn $ "Summary: " ++ show (getItemSummary item)

getTheItem (Text.Feed.Types.RSSItem i) = i
getOther (Text.RSS.Syntax.RSSItem {rssItemOther = other}) = other
-- -- Probably a 'filter for qPrefix = Just "content"}' function?

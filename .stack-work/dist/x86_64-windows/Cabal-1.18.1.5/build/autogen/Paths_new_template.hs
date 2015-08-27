module Paths_new_template (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,1,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\as\\dev\\new_hask_bsb\\.stack-work\\install\\x86_64-windows\\lts-2.17\\7.8.4\\bin"
libdir     = "C:\\Users\\as\\dev\\new_hask_bsb\\.stack-work\\install\\x86_64-windows\\lts-2.17\\7.8.4\\lib\\x86_64-windows-ghc-7.8.4\\new-template-0.1.0.0"
datadir    = "C:\\Users\\as\\dev\\new_hask_bsb\\.stack-work\\install\\x86_64-windows\\lts-2.17\\7.8.4\\share\\x86_64-windows-ghc-7.8.4\\new-template-0.1.0.0"
libexecdir = "C:\\Users\\as\\AppData\\Roaming\\cabal\\new-template-0.1.0.0"
sysconfdir = "C:\\Users\\as\\AppData\\Roaming\\cabal\\etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "new_template_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "new_template_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "new_template_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "new_template_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "new_template_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)

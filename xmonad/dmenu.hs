------------------------------------------------------------------------------
-- |
-- Module      :  DMenu 
-- Copyright   :  (c) Mads N Noe 2009
-- Maintainer  :  mntnoe (@) gmail.com
-- License     :  as-is
-- 
-- DMenu helper functions.
-- 
------------------------------------------------------------------------------

module DMenu where

-- Haskell modules
import Data.List (intercalate)

-- XMonad modules
import XMonad.Prompt

-- | Run command in path.
dmenuRun xpc = intercalate " " $ "dmenu_run" : dmenuArgs xpc "Run:"

-- | DMenu options based on an XPC.
dmenuArgs xpc prompt = 
    [ "-b"
    , "-fn" , font     xpc
    , "-nb" , bgColor  xpc
    , "-nf" , fgColor  xpc
    , "-sb" , bgHLight xpc
    , "-sf" , fgHLight xpc
    , "-p"  , prompt
    ]

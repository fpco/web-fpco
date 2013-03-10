module Snap.Http.Server.Env
    ( httpServe
    , module Snap.Http.Server
    ) where

import           Safe               (readMay)
import           Snap.Core          (Snap)
import           Snap.Http.Server   hiding (httpServe)
import qualified Snap.Http.Server   as Snap
import           System.Environment (getEnvironment)

-- | An alternate @httpServe@ which reads the port to listen to from the PORT
-- environment variable. This configuration approach is used by the FP Complete
-- School of Haskell and the Keter deployment manager.
httpServe :: Config Snap a -> Snap () -> IO ()
httpServe config snap = do
    env <- getEnvironment
    case lookup "PORT" env of
        Nothing -> error "PORT environment variable not found"
        Just portS ->
            case readMay portS of
                Nothing -> error $ "Invalid PORT enviornment variable: " ++ portS
                Just port -> Snap.httpServe (setPort port config) snap

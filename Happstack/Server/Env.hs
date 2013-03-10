module Happstack.Server.Env
    ( simpleHTTP
    , module Happstack.Server
    ) where

import           Happstack.Server   hiding (simpleHTTP)
import qualified Happstack.Server   as Happstack
import           Safe               (readMay)
import           System.Environment (getEnvironment)

-- | An alternate @simpleHTTP@ which reads the port to listen to from the PORT
-- environment variable. This configuration approach is used by the FP Complete
-- School of Haskell and the Keter deployment manager.
simpleHTTP :: ToMessage a => Conf -> ServerPartT IO a -> IO ()
simpleHTTP conf serverpart = do
    env <- getEnvironment
    case lookup "PORT" env of
        Nothing -> error "PORT environment variable not found"
        Just portS ->
            case readMay portS of
                Nothing -> error $ "Invalid PORT enviornment variable: " ++ portS
                Just port' -> Happstack.simpleHTTP conf
                    { port = port'
                    } serverpart

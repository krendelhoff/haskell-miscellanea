module MyRWT where

import           Control.Monad.Trans        (lift)
import           Control.Monad.Trans.Reader
import           Control.Monad.Trans.Writer
import           Data.Char                  (toUpper)

type MyRWT m = ReaderT [String] (WriterT String m)

runMyRWT :: MyRWT m a -> [String] -> m (a, String)
runMyRWT mT = runWriterT . runReaderT mT

myWithReader :: Monad m => ([String] -> [String]) -> MyRWT m a -> MyRWT m a
myWithReader f = withReaderT f

myAsks :: Monad m => ([String] -> a) -> MyRWT m a
myAsks = asks

myTell :: Monad m => String -> MyRWT m ()
myTell = lift . tell

myLift :: Monad m => m a -> MyRWT m a
myLift = lift . lift

logFirstAndRetSecond :: MyRWT IO String
logFirstAndRetSecond = do
  el1 <- myAsks head
  myLift $ putStrLn $ "First is " ++ show el1
  el2 <- myAsks (map toUpper . head . tail)
  myLift $ putStrLn $ "Second is " ++ show el2
  myTell el1
  return el2

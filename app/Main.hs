module Main where

import           FizzBuzz           (fizzbuzz)
import           System.Environment

play :: Int -> [String]
play n = map fizzbuzz [1..n]

main :: IO ()
main = do
  n <- fmap (read . head) getArgs :: IO Int
  mapM_ putStrLn (play n)


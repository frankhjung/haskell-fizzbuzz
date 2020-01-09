module Main where

import           FizzBuzz           (fizzbuzz, fizzbuzz')
import           System.Environment

play :: Int -> [String]
play n = map fizzbuzz [1..n]

play' :: Int -> [String]
play' = fizzbuzz'

main :: IO ()
main = do
  n <- fmap (read . head) getArgs :: IO Int
  mapM_ putStrLn (play' n)


module Main (main) where

import           FizzBuzz           (fizzbuzz1, fizzbuzz2)
import           System.Environment (getArgs)

play1 :: Int -> [String]
play1 n = map fizzbuzz1 [1..n]

play2 :: Int -> [String]
play2 = fizzbuzz2

main :: IO ()
main = do
  n <- fmap (read . head) getArgs :: IO Int
  mapM_ print $ zip3 [1..n] (play1 n) (play2 n)

module Main where

import           FizzBuzz           (fizzbuzz1, fizzbuzz2)
import           System.Environment

play1 :: Int -> [String]
play1 n = map fizzbuzz1 [1..n]

play2 :: Int -> [String]
play2 = fizzbuzz2

main :: IO ()
main = do
  n <- fmap (read . head) getArgs :: IO Int
  putStrLn "fizzbuzz 1"
  mapM_ putStrLn (play1 n)
  putStrLn "\nfizzbuzz 2"
  mapM_ putStrLn (play2 n)

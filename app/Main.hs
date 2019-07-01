module Main where

import           FizzBuzz (fizzbuzz)

main :: IO ()
main = mapM_ (putStrLn . fizzbuzz) [1..30]


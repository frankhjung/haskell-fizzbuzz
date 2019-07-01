{-# LANGUAGE UnicodeSyntax #-}

{-|

  Module      : FizzBuzz
  Description : An implementation of FizzBuzz
  Copyright   : © Frank Jung, 2019
  License     : GPL-3
  Maintainer  : frankhjung@linux.com
  Stability   : education
  Portability : Linux

-}

module FizzBuzz (fizzbuzz) where

-- | Given n returns fizzbuzz returns:
--
--    * fizz if modulo 3
--    * buzz if modulo 5
--    * fizzbuzz if modulo 3 and 5
--    * n for all other numbers
fizzbuzz :: Int -> String
fizzbuzz n = (fizz . buzz) id (show n)
  where
    fizz  | n `mod` 3 == 0 = \x -> const ("fizz" ++ x "")
          | otherwise = id
    buzz  | n `mod` 5 == 0 = \x -> const ("buzz" ++ x "")
          | otherwise = id

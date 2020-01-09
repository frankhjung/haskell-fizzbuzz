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

module FizzBuzz (fizzbuzz, fizzbuzz') where

import           Data.List  (zipWith)
import           Data.Maybe (fromMaybe)

-- | Given n returns fizzbuzzes.
--
--    * fizz if modulo 3
--    * buzz if modulo 5
--    * fizzbuzz if modulo 3 and 5
--    * n for all other numbers
fizzbuzz :: Int -> String
fizzbuzz n = (fizz . buzz) id (show n)
  where
    fizz | n `mod` 3 == 0 = \x -> const ("fizz" ++ x "")
         | otherwise = id
    buzz | n `mod` 5 == 0 = \x -> const ("buzz" ++ x "")
         | otherwise = id

-- | Semigroup resonance FizzBuzz by Mark Seemann.
-- This "FizzBuzz kata uses the fundamental concepts of catamorphism, semigroup
-- and monoid. No if-then-else instructions or pattern matching is required.
-- Instead, we use the string concatenation semigroup to enable resonance between
-- two pulses, and the maybe catamorphism to combine with the list of numbers."
-- Source: https://blog.ploeh.dk/2019/12/30/semigroup-resonance-fizzbuzz/
fizzbuzz' :: Int -> [String]
fizzbuzz' n = zipWith fromMaybe numbers fizzBuzzes
  where
    numbers :: [String]
    numbers = show <$> [1..n]
    fizzes :: [Maybe String]
    fizzes = cycle [Nothing, Nothing, Just "Fizz"]
    buzzes :: [Maybe String]
    buzzes = cycle [Nothing, Nothing, Nothing, Nothing, Just "Buzz"]
    fizzBuzzes :: [Maybe String]
    fizzBuzzes = zipWith (<>) fizzes buzzes


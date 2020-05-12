{-# LANGUAGE UnicodeSyntax #-}

{-|

  Module      : FizzBuzz
  Description : An implementation of FizzBuzz
  Copyright   : © Frank Jung, 2019, 2020
  License     : GPL-3
  Maintainer  : frankhjung@linux.com
  Stability   : education
  Portability : Linux

-}

module FizzBuzz (fizzbuzz1, fizzbuzz2) where

-- import           Data.List  (zipWith)
import           Data.Maybe (fromMaybe)

-- | Given n returns fizzbuzzes.
--
--    * fizz if modulo 3
--    * buzz if modulo 5
--    * fizzbuzz if modulo 3 and 5
--    * n for all other numbers
--
--  Source: https://themonadreader.files.wordpress.com/2014/04/fizzbuzz.pdf
fizzbuzz1 :: Int -> String
fizzbuzz1 n = (test 3 "Fizz" . test 5 "Buzz") id (show n)
  where
    test d s x  | n `mod` d == 0 = const (s ++ x "")
                | otherwise = x

-- | Semigroup resonance FizzBuzz by Mark Seemann.
--
-- This "FizzBuzz Kata uses the fundamental concepts of catamorphism, semigroup
-- No if-then-else instructions or pattern matching is required.
-- Instead, we use the string concatenation semigroup to enable resonance between
-- two pulses, and the maybe catamorphism to combine with the list of numbers."
--
-- Source: https://blog.ploeh.dk/2019/12/30/semigroup-resonance-fizzbuzz/
fizzbuzz2 :: Int -> [String]
fizzbuzz2 n = zipWith fromMaybe numbers fizzBuzzes
  where
    numbers :: [String]
    numbers = show <$> [1..n]
    fizzes :: [Maybe String]
    fizzes = cycle [Nothing, Nothing, Just "Fizz"]
    buzzes :: [Maybe String]
    buzzes = cycle [Nothing, Nothing, Nothing, Nothing, Just "Buzz"]
    fizzBuzzes :: [Maybe String]
    fizzBuzzes = zipWith (<>) fizzes buzzes

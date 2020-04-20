{-# LANGUAGE OverloadedStrings #-}

module Main(main) where

import           FizzBuzz        (fizzbuzz1, fizzbuzz2)
import           Test.Hspec      (describe, hspec, it, shouldBe)
import           Test.QuickCheck

genMod3 :: Gen Int
genMod3 = (arbitrary :: Gen Int) `suchThat` \x -> x > 0 && x `mod` 3 == 0 && x `mod` 5 /= 0

genMod5 :: Gen Int
genMod5 = (arbitrary :: Gen Int) `suchThat` \x -> x > 0 && x `mod` 3 /= 0 && x `mod` 5 == 0

genMod3and5 :: Gen Int
genMod3and5 = (\x -> 15 * abs x) `fmap` (arbitrary :: Gen Int) `suchThat` (> 0)

genNotFizzBuzz :: Gen Int
genNotFizzBuzz = abs `fmap` (arbitrary :: Gen Int) `suchThat` \x -> x `mod` 3 /= 0 && x `mod` 5 /= 0


main :: IO ()
main = hspec $

  describe "modulo checks fizzbuzz1" $ do
    it "if modulo 3 then fizz" $
      property $ forAll genMod3 $ \n -> fizzbuzz1 n `shouldBe` "Fizz"
    it "if modulo 5 then buzz" $
      property $ forAll genMod5 $ \n -> fizzbuzz1 n `shouldBe` "Buzz"
    it "if modulo 3 & 5 then fizzbuzz" $
      property $ forAll genMod3and5 $ \n -> fizzbuzz1 n `shouldBe` "FizzBuzz"
    it "if not modulo 3 or 5 then n" $
      property $ forAll genNotFizzBuzz $ \n -> fizzbuzz1 n `shouldBe` show n
    it "fizzbuzz1 == fizzbuzz2" $
      property $ forAll genNotFizzBuzz $ \n -> map fizzbuzz1 [1..n] `shouldBe` fizzbuzz2 n

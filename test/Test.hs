{-# LANGUAGE OverloadedStrings #-}

module Main(main) where

import           FizzBuzz        (fizzbuzz)
import           Test.Hspec      (describe, hspec, it, shouldBe)
import           Test.QuickCheck

genMod3 :: Gen Int
genMod3 = abs `fmap` (arbitrary :: Gen Int) `suchThat` \x -> x `mod` 3 == 0 && x `mod` 5 /= 0

genMod5 :: Gen Int
genMod5 = abs `fmap` (arbitrary :: Gen Int) `suchThat` \x -> x `mod` 3 /= 0 && x `mod` 5 == 0

genMod3and5 :: Gen Int
genMod3and5 = abs `fmap` (arbitrary :: Gen Int) `suchThat` \x -> x `mod` 3 == 0 && x `mod` 5 == 0

genNotFizzBuzz :: Gen Int
genNotFizzBuzz = abs `fmap` (arbitrary :: Gen Int) `suchThat` \x -> x `mod` 3 /= 0 && x `mod` 5 /= 0


main :: IO ()
main = hspec $

  describe "modulo checks" $ do
    it "modulo 3 == fizz" $
      property $ forAll genMod3 $ \n -> fizzbuzz n `shouldBe` "fizz"
    it "modulo 5 == buzz" $
      property $ forAll genMod5 $ \n -> fizzbuzz n `shouldBe` "buzz"
    it "modulo 3 & 5 == fizzbuzz" $
      property $ forAll genMod3and5 $ \n -> fizzbuzz n `shouldBe` "fizzbuzz"
    it "not modulo 3 or 5 == n" $
      property $ forAll genNotFizzBuzz $ \n -> fizzbuzz n `shouldBe` show n

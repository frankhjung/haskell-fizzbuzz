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

  -- describe "return number if not multiples of 3 or 5" $ do
  --   context "1 = 1?" $
  --     it "returns 1" $
  --       fizzbuzz 1 `shouldBe` "1"
  --   context "8 = 8?" $
  --     it "returns 8" $
  --       fizzbuzz 8 `shouldBe` "8"

  -- describe "fizz are multiples of 3" $ do
  --   context "3 = fizz?" $
  --     it "returns fizz" $
  --       fizzbuzz 3 `shouldBe` "fizz"
  --   context "9 = fizz?" $
  --     it "returns fizz" $
  --       fizzbuzz 9 `shouldBe` "fizz"

  -- describe "buzz are multiples of 5" $ do
  --   context "5 = buzz?" $
  --     it "returns buzz" $
  --       fizzbuzz 5 `shouldBe` "buzz"
  --   context "10 = buzz?" $
  --     it "returns buzz" $
  --       fizzbuzz 10 `shouldBe` "buzz"

  -- describe "fizzbuzz are multiples of 3 and 5" $ do
  --   context "15 = fizzbuzz?" $
  --     it "returns fizzbuzz" $
  --       fizzbuzz 15 `shouldBe` "fizzbuzz"
  --   context "30 = fizzbuzz?" $
  --     it "returns fizzbuzz" $
  --       fizzbuzz 30 `shouldBe` "fizzbuzz"


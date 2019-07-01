{-# LANGUAGE OverloadedStrings #-}

module Main(main) where

import           FizzBuzz   (fizzbuzz)
import           Test.Hspec (context, describe, hspec, it, shouldBe)

main :: IO ()
main = hspec $ do

  describe "return number if not multiples of 3 or 5" $ do
    context "1 = 1?" $
      it "returns 1" $
        fizzbuzz 1 `shouldBe` "1"
    context "8 = 8?" $
      it "returns 8" $
        fizzbuzz 8 `shouldBe` "8"

  describe "fizz are multiples of 3" $ do
    context "3 = fizz?" $
      it "returns fizz" $
        fizzbuzz 3 `shouldBe` "fizz"
    context "9 = fizz?" $
      it "returns fizz" $
        fizzbuzz 9 `shouldBe` "fizz"

  describe "buzz are multiples of 5" $ do
    context "5 = buzz?" $
      it "returns buzz" $
        fizzbuzz 5 `shouldBe` "buzz"
    context "10 = buzz?" $
      it "returns buzz" $
        fizzbuzz 10 `shouldBe` "buzz"

  describe "fizzbuzz are multiples of 3 and 5" $ do
    context "15 = fizzbuzz?" $
      it "returns fizzbuzz" $
        fizzbuzz 15 `shouldBe` "fizzbuzz"
    context "30 = fizzbuzz?" $
      it "returns fizzbuzz" $
        fizzbuzz 30 `shouldBe` "fizzbuzz"


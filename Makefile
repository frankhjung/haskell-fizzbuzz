#!/usr/bin/env make

.PHONY: build check tags style lint test exec doc clean cleanall setup

TARGET	:= fizzbuzz
SRCS	:= $(wildcard *.hs */*.hs)
ARGS	?= 15

.PHONY:	default
default: check build test

all:	check build test doc exec

check:	tags style lint

tags:
	@hasktags --ctags --extendedctag $(SRCS)

style:
	@stylish-haskell -c .stylish-haskell.yaml -i $(SRCS)

lint:
	@hlint $(SRCS)

build:
	@stack build

test:
	@stack test

exec:	# Example:  make ARGS="30" exec
	@stack exec $(TARGET) -- $(ARGS)

doc:
	@stack test --coverage
	@stack haddock --fast

install:
	@stack install --local-bin-path $(HOME)/bin

setup:
	@stack update
	@stack setup
	#stack build
	@stack query
	@stack ls dependencies
	#stack exec ghc-pkg -- list

ghci:
	@stack ghci --ghci-options -Wno-type-defaults

clean:
	@stack clean
	@$(RM) -rf *.tix

cleanall: clean
	@$(RM) -rf .stack-work/
	@$(RM) -rf $(patsubst %.hs, %.hi, $(SRCS))
	@$(RM) -rf $(patsubst %.hs, %.o, $(SRCS))

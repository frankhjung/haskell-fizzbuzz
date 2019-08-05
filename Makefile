#!/usr/bin/env make

.PHONY: build check tags style lint test exec doc clean cleanall setup

TARGET	:= fizzbuzz
SRCS	:= $(wildcard *.hs **/*.hs)

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
	@stack build --pedantic --no-test --ghc-options='-O2'

test:
	@stack test

exec:
	@stack exec $(TARGET) 30

doc:
	@stack test --coverage
	@stack haddock

setup:
	-stack setup
	-stack build --dependencies-only --test --no-run-tests
	-stack query
	-stack ls dependencies

clean:
	@stack clean
	@$(RM) -rf $(TARGET).tix

cleanall: clean
	@$(RM) -rf .stack-work/
	@$(RM) -rf $(patsubst %.hs, %.hi, $(SRCS))
	@$(RM) -rf $(patsubst %.hs, %.o, $(SRCS))

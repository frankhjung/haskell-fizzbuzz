#!/usr/bin/env make

.PHONY: build check tags style lint test exec doc clean cleanall setup

TARGET	:= fizzbuzz
SRCS	:= $(wildcard *.hs **/*.hs)

.default: build

build:	check
	@stack build

all:	build test doc exec

check:	tags style lint

tags:
	@hasktags --ctags --extendedctag $(SRCS)

style:
	@stylish-haskell -c .stylish-haskell.yaml -i $(SRCS)

lint:
	@hlint $(SRCS)

test:
	@stack test --coverage

exec:
	@stack exec $(TARGET)

doc:
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

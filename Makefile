#!/usr/bin/env make

.PHONY: build check default tags style lint test exec doc clean cleanall setup

TARGET	:= fizzbuzz
SRCS	:= $(wildcard *.hs */*.hs)
ARGS	?= 15

default: check build test

all:	check build test doc exec

check:	tags style lint

tags:	$(SRCS)
	@echo tags ...
	@hasktags --ctags --extendedctag $(SRCS)

style:	$(SRCS)
	@echo style ...
	@stylish-haskell --config=.stylish-haskell.yaml --inplace $(SRCS)

lint:	$(SRCS)
	@echo lint ...
	@hlint --color $(SRCS)

build:
	@echo build ...
	@stack build --pedantic --no-test

test:
	@echo test ...
	@stack test

exec:	# Example:  make ARGS=30 exec
	@stack exec $(TARGET) -- $(ARGS)

doc:
	@stack haddock --no-rerun-tests --no-reconfigure --haddock-deps

install:
	@stack install --local-bin-path $(HOME)/bin

setup:
	@stack update
	@stack setup
	@stack build
	@stack query
	@stack ls dependencies
	#stack exec ghc-pkg -- list

ghci:
	@stack ghci --ghci-options -Wno-type-defaults

clean:
	@stack clean
	@$(RM) -rf *.tix

cleanall: clean
	@stack clean --full
	#$(RM) -rf .stack-work/
	#$(RM) -rf $(patsubst %.hs, %.hi, $(SRCS))
	#$(RM) -rf $(patsubst %.hs, %.o, $(SRCS))

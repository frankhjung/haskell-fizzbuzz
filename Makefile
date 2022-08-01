#!/usr/bin/env make

.PHONY: build check default tags style lint test exec doc clean cleanall setup

TARGET	:= fizzbuzz
SUBS	:= $(wildcard */)
SRCS	:= $(wildcard $(addsuffix *.hs, $(SUBS)))
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
	@hlint --cross --color --show $(SRCS)
	@cabal check

build:
	@echo build ...
	@stack build --verbosity info --pedantic --no-test

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

ghci:
	@stack ghci --ghci-options -Wno-type-defaults

clean:
	@stack clean
	@$(RM) -rf *.tix

cleanall: clean
	@stack clean --full

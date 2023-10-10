#!/usr/bin/env make


ARGS	?= 15
SRC	:= $(wildcard *.hs, */*.hs)
RTSOPTS	?= +RTS -s
TARGET	:= fizzbuzz
YAML	:= $(shell git ls-files | grep --perl \.y?ml)

.PHONY: default
default:	format check build test exec

.PHONY: all
all:	format check build test doc exec

.PHONY: format
format:
	@echo format ...
	@stylish-haskell --config=.stylish-haskell.yaml --inplace $(SRC)
	@cabal-fmt --inplace $(TARGET).cabal

.PHONY: check
check:	tags lint

.PHONY: tags
tags:
	@echo tags ...
	@hasktags --ctags --extendedctag $(SRC)

.PHONY: lint
lint:
	@echo lint ...
	@cabal check --verbose
	@hlint --cross --color --show $(SRC)
	@yamllint --strict $(YAML)

.PHONY: build
build:
	@echo build ...
	@stack build --pedantic

.PHONY: test
test:
	@echo test ...
	@stack test

.PHONY: doc
doc:
	@stack haddock

.PHONY: exec
exec:	# Example:  make ARGS=30 exec
	-stack exec $(TARGET) -- $(ARGS) $(RTSOPTS)

.PHONY: setup
setup:
	stack path
	stack query
	stack ls dependencies

ghci:
	@stack ghci --ghci-options -Wno-type-defaults

.PHONY: clean
clean:
	@stack clean
	@cabal clean

.PHONY: cleanall
cleanall: clean
	@stack purge

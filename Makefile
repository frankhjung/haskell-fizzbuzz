#!/usr/bin/env make


ARGS	?= 15
SRC	:= $(wildcard *.hs, */*.hs)
RTSOPTS	?= +RTS -s
TARGET	:= fizzbuzz
YAML	:= $(shell git ls-files | grep --perl \.y?ml)

.PHONY: default
default:	check build test exec

.PHONY: all
all:	check build test doc exec

.PHONY: check
check:	tags style lint

.PHONY: tags
tags:	$(SRCS)
	@echo tags ...
	@hasktags --ctags --extendedctag $(SRC)

.PHONY: style
style:	$(SRCS)
	@echo style ...
	@stylish-haskell --verbose --config=.stylish-haskell.yaml --inplace $(SRC)

.PHONY: lint
lint:	$(SRC)
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
	@stack haddock --no-haddock-deps

.PHONY: exec
exec:	# Example:  make ARGS=30 exec
	-stack exec $(TARGET) -- $(ARGS) $(RTSOPTS)

.PHONY: install
install:
	@stack install --local-bin-path $(HOME)/bin

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

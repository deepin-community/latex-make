all:

-include LaTeX.mk

all:
	@echo $(patsubst %/include/LaTeX.mk,%,$(filter %/include/LaTeX.mk,$(lastword $(MAKEFILE_LIST))))

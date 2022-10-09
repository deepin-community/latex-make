
#COMPATIBILITY=true

# example-luatex must be compiled with lualatex
LU_lualatex-example_FLAVORS=LUALATEX

all: pdf

example.pdf:

example.ps:

traces-tsi.pdf_DEPENDS = eps/paje.pdf

clean::
	$(RM) eps/paje.pdf

export TEXMFHOME:=texmf
include texmf/scripts/latex-make/LaTeX.mk

clean::
	$(RM) $(BIB_SLAVES)

distclean::
	$(MAKE) LaTeX-Make-local-uninstall TEXMF_INSTALL_ROOT_DIR=texmf
	$(RM) -rv texmf

../src/LaTeX.mk:
	$(MAKE) -C ../src

texmf/scripts/latex-make/LaTeX.mk: ../src/LaTeX.mk
	$(MAKE) -f ../src/LaTeX.mk MAKE="$(MAKE) -f ../src/LaTeX.mk" LaTeX-Make-local-install TEXMF_INSTALL_ROOT_DIR=texmf TEXINPUTS=../src TEXMFSCRIPTS=../src

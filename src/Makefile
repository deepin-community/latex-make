
####[ Check Software ]################################################
ifeq ($(filter else-if,$(.FEATURES)),)
$(error GNU Make 3.81 needed. Please, update your software.)
	exit 1
endif

####[ Default installation ]##########################################
-include ../config.mk

prefix ?= /usr/local

texmf_prefix ?= $(prefix)/share/texmf

PKGNAME=latex-make

INCLUDEDIR=$(prefix)/include

LATEXDIR=$(texmf_prefix)/tex/latex/$(PKGNAME)
LATEXCFGDIR=$(texmf_prefix)/tex/latex/$(PKGNAME)
DOCDIR=$(texmf_prefix)/doc/latex/$(PKGNAME)
SCRIPTSDIR=$(texmf_prefix)/scripts/$(PKGNAME)

SCRIPTS=figdepth.py gensubfig.py svg2dev.py svgdepth.py latexfilter.py
INCFILES=LaTeX.mk
STYFILES= *.sty
CFGFILES= *.cfg
DOCFILES= *.pdf


####[ Targets ]######################################################

all: generate

.PHONY: all generate install

GENFILES= figlatex.sty figlatex.cfg texgraphicx.sty \
		pdfswitch.sty texdepends.sty \
		LaTeX.mk LaTeX.mk.conf $(SCRIPTS)

DTX_SOURCES=$(wildcard *.dtx)

generate: $(GENFILES)

install: $(GENFILES) doc
	install -m 755 -d $(DESTDIR)$(LATEXDIR)
	install -m 644 $(STYFILES) $(DESTDIR)$(LATEXDIR)
	install -m 755 -d $(DESTDIR)$(LATEXCFGDIR)
	install -m 644 $(CFGFILES) $(DESTDIR)$(LATEXCFGDIR)
	install -m 755 -d $(DESTDIR)$(SCRIPTSDIR)
	install -m 755 $(SCRIPTS) $(DESTDIR)$(SCRIPTSDIR)
	install -m 644 $(INCFILES) $(DESTDIR)$(SCRIPTSDIR)
	install -m 755 -d $(DESTDIR)$(INCLUDEDIR)
	ln -sf $(SCRIPTSDIR)/LaTeX.mk $(DESTDIR)$(INCLUDEDIR)/
	install -m 755 -d $(DESTDIR)$(DOCDIR)
	install -m 644 $(DOCFILES) $(DESTDIR)$(DOCDIR)
	if [ -w $(DESTDIR)$(texmf_prefix)/ls-R ]; then texhash $(DESTDIR)$(texmf_prefix) ; fi


$(GENFILES): stamp.latex-make

stamp.latex-make $(CURDIR)/LaTeX.mk: latex-make.ins $(DTX_SOURCES)
	latex latex-make.ins
	chmod +x $(SCRIPTS)
	touch $@
	sed -i.bak \
		-e 's|^\(_LaTeX_Make_BINORIGDIR=\).*|\1$(SCRIPTSDIR)|' \
		-e 's|^\(_LaTeX_Make_TEXORIGDIR=\).*|\1$(LATEXDIR)|' \
		LaTeX.mk
	$(RM) LaTeX.mk.bak

distclean::
	$(RM) $(GENFILES) stamp.latex-make

clean::
	$(RM) latex-make.log

doc: pdf

LU_MASTERS=figlatex texdepends latex-make  #pdfswitch texdepends

DEPENDS=LaTeX.mk $(SCRIPTS)
latex-make_MAIN=latex-make.dtx
figlatex_MAIN=figlatex.dtx
texdepends_MAIN=texdepends.dtx

# use local files by default
export TEXINPUTS:=.$(addprefix :,$(TEXINPUTS))::
export TEXMFSCRIPTS:=.$(addprefix :,$(TEXMFSCRIPTS))::

#LATEX=latex -v

# Force using local LaTeX.mk and not system-wide LaTeX.mk if already installed

include $(CURDIR)/LaTeX.mk


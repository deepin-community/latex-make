ifeq ($(filter else-if,$(.FEATURES)),)
$(error GNU Make 3.81 or latter needed. Please, update your software.)
	exit 1
endif

.PHONY: all install clean distclean dist ctan

-include config.mk

PKGNAME=latex-make

all:
	$(MAKE) -C src doc

check: all
	$(MAKE) -C examples

install: all
	$(MAKE) -C src $@

clean distclean::
	-$(MAKE) -C examples $@
	-$(MAKE) -C MacOSX $@
	-$(MAKE) -C ctan $@
	$(MAKE) -C src $@

distclean::
	$(RM) config.mk

VERSION=$(shell cat VERSION)

check-version:
	@echo 'grep "[0-9] v" src/*.dtx | grep -v " v$(VERSION)"'
	@if grep "[0-9] v" src/*.dtx | grep -v " v$(VERSION)"; then \
		printf "\nSome versions have not been updated. Aborting.\n\n" ; \
		exit 1 ;\
	fi
	@echo 'grep "[0-9] v" src/*.dtx'
	@if test "$$(grep -h "[0-9] v" src/*.dtx | sed -e 's/\(^.*[0-9] v[0-9.]*\) .*/\1/' | uniq | wc -l)" != 1 ; then \
		printf "\nSome versions are different. Aborting.\n\n" ; \
		exit 1 ;\
	fi
	@echo 'head -1 Changelog | grep -v " $(VERSION)"'
	@if head -1 Changelog | grep -v " $(VERSION)"; then \
		printf "\nChangelog have not been updated. Aborting.\n\n" ; \
		exit 1 ;\
	fi

dist: check-version
	if [ -d .svn ]; then \
		$(MAKE) dist-svn; \
	elif [ -d .git ]; then \
		$(MAKE) dist-git; \
	else \
		echo "No way to build dist without SCM"; \
		exit 1; \
	fi
	$(MAKE) dist-ctan

dist-svn:
	if [ "$$(svn st)" != "" ] ;then svn st ; exit 1 ; fi
	svn export . $(PKGNAME)-$(VERSION)
	tar cvzf $(PKGNAME)-$(VERSION).tar.gz $(PKGNAME)-$(VERSION)
	rm -rf $(PKGNAME)-$(VERSION)

dist-git:
	if ! LC_ALL=C git status | grep -sq '^nothing to commit' ; then git status ; exit 1 ; fi
	git archive --format=tar --prefix=$(PKGNAME)-$(VERSION)/ HEAD | gzip -9 > $(PKGNAME)-$(VERSION).tar.gz

dist-ctan: check-version
	$(MAKE) -C ctan

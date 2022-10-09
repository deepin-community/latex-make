
include Makefile.config

PACKAGES=latex-make.pkg uninstall-latex-make.pkg

DISK=LaTeX-Make-rw.dmg
FINALDISK=LaTeX-Make-$(VERSION)-$(PACKAGE_SUBVER).dmg
VOLUME=LaTeX Make

SUBDIRS=$(basename $(PACKAGES))

all: $(FINALDISK)

.PHONY: distclean clean all
.PHONY: $(addsuffix -distclean,$(SUBDIRS)) $(addsuffix -clean,$(SUBDIRS))

$(addsuffix -distclean,$(SUBDIRS)): %-distclean:
	$(MAKE) -C $* distclean

$(addsuffix -clean,$(SUBDIRS)): %-clean:
	$(MAKE) -C $* clean

distclean:: clean $(addsuffix -distclean,$(SUBDIRS))

distclean::
	$(RM) -r $(FINALDISK)

clean:: $(addsuffix -clean,$(SUBDIRS))

clean::
	$(RM) $(DISK) $(PACKAGES)

$(PACKAGES): %.pkg:
	$(MAKE) -C $* $@
	ln -s $*/$@ $@

$(DISK): $(PACKAGES)
	-$(RM) $@
	hdiutil create -size 5m -fs HFS+ -volname "$(VOLUME)" $@
	hdiutil attach $@
	DEST=$$(hdiutil attach $@ | sed -e '/Apple_HFS/s/.*Apple_HFS[[:space:]]*//p;d') ; \
	cp ../COPYING "$$DEST" && \
	cp -r $(PACKAGES) "$$DEST"
	DEV=$$(hdiutil attach $@ | sed -e '1s/[[:space:]].*//p;d') ; \
	hdiutil detach $$DEV

$(FINALDISK): $(DISK)
	-$(RM) $@
	hdiutil convert $< -format UDZO -o $@
	hdiutil internet-enable -yes $@
	cp $@ ..


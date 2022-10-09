
include ../Makefile.config

PACKAGE_NAME=$(notdir $(CURDIR))

package: $(PACKAGE_NAME).pkg

$(PACKAGE_NAME).pkg: Package_contents Install_resources Info.plist Description.plist
	$(PACKAGEMAKER) -build -v \
		-p "$@" \
		-f Package_contents \
		-r Install_resources \
		-i Info.plist \
		-d Description.plist
	
%.plist: plist/%.plist.in
	sed -e 's/@VERSION@/$(VERSION)/g' < $< > $@

clean::
	$(RM) -r $(PACKAGE_NAME).pkg

distclean:: clean

.PHONY: distclean clean


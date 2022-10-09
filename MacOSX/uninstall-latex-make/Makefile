
all: package

include ../package.mk

$(PACKAGE_NAME).pkg: Info.plist Description.plist Package_contents

Package_contents:
	mkdir $@

.PHONY: distclean clean all package

clean::
	$(RM) -r Info.plist Description.plist Package_contents


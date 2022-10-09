
all: package

include ../package.mk

package: $(PACKAGE_NAME).pkg

$(PACKAGE_NAME).pkg: Info.plist Description.plist \
	Install_resources/License.txt Install_resources/License.txt \
	Install_resources/Welcome.txt Package_contents

Package_contents:
	$(RM) -r $@
	$(MAKE) -C ../.. install DESTDIR=$(CURDIR)/$@ \
		texmf_prefix='/usr/local/texlive/texmf-local' \
		prefix='/usr/local'

Install_resources/License.txt: ../../COPYING
	cp $< $@

Install_resources/Welcome.txt: plist/Welcome.txt.start ../../INSTALL
	cat plist/Welcome.txt.start > $@
	sed -e '/REQUIREMENTS/,$$p;d' < ../../INSTALL >> $@

.PHONY: distclean clean all package

clean::
	$(RM) -r Package_contents Info.plist \
		Description.plist \
		Install_resources/License.txt \
		Install_resources/Welcome.txt



ARCHIVE_NAME=latex-make

all: ctan

ctan: $(ARCHIVE_NAME).zip

$(ARCHIVE_NAME).zip: $(ARCHIVE_NAME) FORCE
	$(RM) $@
	zip -r $@ $(ARCHIVE_NAME)

$(ARCHIVE_NAME): FORCE
	mkdir -p $@
	$(MAKE) -C .. check
	cp ../src/*.dtx ../src/*.ins ../src/*.pdf $@
	< ./README sed -e 's,@VERSION@,VERSION: '$$(cat ../VERSION)',' \
		> $@/README

FORCE:

.phony: FORCE all ctan clean distclean

clean:
	$(RM) -r $(ARCHIVE_NAME)

distclean: clean
	$(RM) $(ARCHIVE_NAME).zip

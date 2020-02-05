
PREFIX = /usr/local

ALL_SOURCES = $(wildcard *.tsv)
INSTALL_DIR = $(DESTDIR)$(PREFIX)/bin

export SH_FILE  = cl-bible.sh
export AWK_FILE = cl-bible.awk

all: $(ALL_SOURCES:%.tsv=build/%)

build/%: build %.tsv $(SH_FILE) $(AWK_FILE)
	$(eval CLI_NAME := $*)
	$(eval TSV_FILE := $*.tsv)
	@cat $(SH_FILE) \
		| sed "s/@source@/\"$(TSV_FILE)\"/" \
		| sed "s/@cli_name@/\"$(CLI_NAME)\"/" \
		| sed "s/@awk_file@/\"$(AWK_FILE)\"/" > $@
	echo 'exit 0' >> $@
	echo "#EOF" >> $@
	tar cz $(AWK_FILE) $(TSV_FILE) >> $@
	echo "$@"

build:
	mkdir -p build

clean: $(ALL_SOURCES:%.tsv=clean-%)

clean-%:
	rm -f build/$*

install: $(ALL_SOURCES:%.tsv=install-%)

install-%: build/%
	mkdir -p $(INSTALL_DIR)
	cp -f build/$* $(INSTALL_DIR)
	chmod 755 $(INSTALL_DIR)/$*

uninstall: $(ALL_SOURCES:%.tsv=uninstall-%)

uninstall-%:
	rm -f $(DESTDIR)$(PREFIX)/bin/$*

.PHONY: all clean clean-% install install-% uninstall uninstall-%

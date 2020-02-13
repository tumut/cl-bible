
PREFIX = /usr/local

BUILD_DIR = bin
INSTALL_DIR = $(DESTDIR)$(PREFIX)/bin

ALL_SOURCES = $(wildcard *.tsv)

ALL_BUILDS = $(wildcard $(BUILD_DIR)/*)
ALL_BUILDS_NAMES = $(ALL_BUILDS:$(BUILD_DIR)/%=%)

ALL_INSTALLED_NAMES = $(wildcard $(INSTALL_DIR)/*)
ALL_INSTALLED_NAMES := $(ALL_INSTALLED_NAMES:$(INSTALL_DIR)/%=%)
ALL_INSTALLED_NAMES := $(filter $(ALL_BUILDS_NAMES), $(ALL_INSTALLED_NAMES))

export SH_FILE  = clb.sh
export AWK_FILE = clb.awk

.DEFAULT_GOAL = build

$(BUILD_DIR)/%: %.tsv $(SH_FILE) $(AWK_FILE)
	$(eval CLI_NAME := $*)
	$(eval TSV_FILE := $*.tsv)
	mkdir -p $(BUILD_DIR)
	cat $(SH_FILE) \
		| sed "s/@source@/\"$(TSV_FILE)\"/" \
		| sed "s/@cli_name@/\"$(CLI_NAME)\"/" \
		| sed "s/@awk_file@/\"$(AWK_FILE)\"/" > $@
	echo 'exit 0' >> $@
	echo "#EOF" >> $@
	tar cz $(AWK_FILE) $(TSV_FILE) >> $@
	: built $@

$(INSTALL_DIR)/%: $(BUILD_DIR)/%
	mkdir -p $(INSTALL_DIR)
	cp -f $(BUILD_DIR)/$* $(INSTALL_DIR)
	chmod 755 $(INSTALL_DIR)/$*
	: installed $*

.PHONY: build
build: $(ALL_SOURCES:%.tsv=$(BUILD_DIR)/%) ;

.PHONY: build-%
.PRECIOUS: $(BUILD_DIR)/%
build-%: $(BUILD_DIR)/% ;

.PHONY: clean
clean: $(ALL_BUILDS_NAMES:%=clean-%) ;

.PHONY: clean-%
clean-%:
	rm -f $(BUILD_DIR)/$*

.PHONY: install
install: $(ALL_BUILDS_NAMES:%=install-%) ;

.PHONY: install-%
.PRECIOUS: $(INSTALL_DIR)/%
install-%: $(INSTALL_DIR)/% ;

.PHONY: uninstall
uninstall: $(ALL_INSTALLED_NAMES:%=uninstall-%) ;

.PHONY: uninstall-%
uninstall-%: $(INSTALL_DIR)/%
	rm -f $(INSTALL_DIR)/$*

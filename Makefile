#
# Authors:
# Copyright 2013 Peter van der Does. All rights reserved.
#

prefix=/opt/wp-plugin-hooks

# files that need mode 755
EXEC_FILES=src/commit-msg
EXEC_FILES+=src/pre-commit
EXEC_FILES+=src/post-commit
EXEC_FILES+=src/prepare-commit-msg

# files that need mode 644
SCRIPT_FILES =src/config.sh
SCRIPT_FILES+=src/gitflow-functions
SCRIPT_FILES+=src/hooks_config.sample
SCRIPT_FILES+=src/jshint.json

all:
	@echo "usage: make install"


install:
	install -d -m 0755 $(prefix)
	install -d -m 0755 $(prefix)/modules
	install -m 0755 $(EXEC_FILES) $(prefix)
	install -m 0644 $(SCRIPT_FILES) $(prefix)
	set -e;for i in src/filter-*; do \
		install -m 0755 "$$i" \
			$(prefix); \
	done
	set -e;for i in src/pre-*; do \
		install -m 0755 "$$i" \
			$(prefix); \
	done
	set -e;for i in src/post-*; do \
		install -m 0755 "$$i" \
			$(prefix); \
	done
	set -e;for i in src/modules/*; do \
		install -m 0644 "$$i" \
			$(prefix)/modules/; \
	done
	
uninstall:
	test -d $(prefix) 
	rm -rf $(prefix)
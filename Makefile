PREFIX ?= /usr
SHARE=$(DESTDIR)$(PREFIX)/share/zigzag

all:

install:
	install -Dpm755 tools/write-configuration.py $(DESTDIR)$(PREFIX)/bin/zigzag-write-configuration
	mkdir -p $(SHARE)
	cp -R ansible $(SHARE)

check:
	ansible-playbook --syntax-check $(SHARE)/ansible/*.yml

.PHONY: all install check

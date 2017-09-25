PREFIX ?= /usr
SHARE=$(DESTDIR)$(PREFIX)/share/zigzag

all:

install:
	install -Dpm755 tools/write-configuration.sh $(DESTDIR)$(PREFIX)/bin/zigzag-write-configuration
	mkdir -p $(SHARE)
	cp -R ansible $(SHARE)

check:
	ansible-playbook --check $(SHARE)/ansible/root.yml

.PHONY: all install check

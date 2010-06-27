PREFIX = /usr/local
SRC := $(wildcard *.sh)

install: $(SRC)

.PHONY: install $(SRC)

install: $(SRC)

$(SRC):
	install $@ $(PREFIX)/bin/$(basename $@)

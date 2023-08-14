SHELL := usr/bin/bash

create:
ifndef name
$(error name not set)
endif
	./script.sh
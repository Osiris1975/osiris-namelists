WORKSPACE?=${shell pwd}
PYEXE?=python3
VERSION := $(shell grep -o '^version="[^"]*"' assets/descriptor.mod | sed 's/version="//;s/"$$//')

.PHONY: version
version:
	@echo $(VERSION)

.PHONY: build
build:
	find . -type f -name 'osiris_namelist*' -delete
	${PYEXE} ../namelist-mod-gen/namelist_mod_gen/namelist_mod_gen.py mod mod/ -n csv/ -m osiris_namelists -a osiris -t -i

.PHONY: deployable
deployable:
	find . -type f -name '*DS_Store' -delete
	mkdir -p mod deployables
	cp -f assets/* mod/osiris_namelists
	cd mod && zip -r "../deployables/osiris_namelists_${VERSION}.zip" * -x "*.DS_Store"

release: build deployable
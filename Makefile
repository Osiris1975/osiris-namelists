WORKSPACE?=${shell pwd}
PYEXE?=python3
VERSION := $(shell grep -o '^version="[^"]*"' assets/descriptor.mod | sed 's/version="//;s/"$$//')

.PHONY: version
version:
	@echo $(VERSION)

.PHONY: build
build_osiris:
	${PYEXE} ../namelist-mod-gen/namelist_mod_gen/namelist_mod_gen.py mod mod -n csv/osiris_namelists -m osiris_namelists -a osiris -t

.PHONY: deployable
deployable:

	mkdir -p mod deployables
	cp -f assets/* mod/osiris_namelists
	cd mod && zip -r "../deployables/osiris_namelists_${VERSION}.zip" * -x "*.DS_Store"

release: build deployable
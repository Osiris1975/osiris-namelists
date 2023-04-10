WORKSPACE?=${shell pwd}
PYEXE?=python3


.PHONY: build
build_osiris:
	${PYEXE} ../namelist-mod-gen/namelist_mod_gen/namelist_mod_gen.py mod mod -n csv/osiris_namelists -m osiris_namelists -a osiris -t

.PHONY: deployable
deployable:
	cp assets/* mod/osiris_namelists
	cd mod && zip -r ../deployables/osiris_namelists_v5_rc.zip * -x "*.DS_Store"

release: build deployable
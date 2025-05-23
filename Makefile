NAME	:= LK56HS
GITROOT	:= $(shell git rev-parse --show-toplevel)
KIBOT	:= $(GITROOT)/libraries/kicad-lkbd/kibot/.bin/kibot

default: export step

export: clean pcb plate

pcb:
	$(info + [$(NAME)] $@)
	mkdir -p ./output/pcb
	$(KIBOT) \
	    -c ./pcb/lk56hs-pcb.kibot.yaml \
	    -b ./pcb/lk56hs-pcb.kicad_pcb \
	    -d output/pcb

plate:
	$(info + [$(NAME)] $@)
	mkdir -p ./output/plate
	$(KIBOT) \
	    -c ./case/plate/lk56hs-plate.kibot.yaml \
	    -b ./case/plate/lk56hs-plate.kicad_pcb \
	    -d output/plate

step:
	$(info + [$(NAME)] $@)
	mkdir -p ./output/step
	$(KIBOT) \
	    -c libraries/kicad-lkbd/kibot/3dexport.kibot.yaml \
	    -b ./pcb/lk56hs-pcb.kicad_pcb \
	    -d output
	$(KIBOT) \
	    -c libraries/kicad-lkbd/kibot/3dexport.kibot.yaml \
	    -b ./case/plate/lk56hs-plate.kicad_pcb \
	    -d output 3d_step

clean:
	$(info + [$(NAME)] $@)
	rm -rf output/pcb output/case output/step

.PHONY: default export pcb plate step clean

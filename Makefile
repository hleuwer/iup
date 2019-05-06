ifeq ($(OS), Windows_NT)
  WINLIBS = iupole iupfiledlg
endif

.PHONY: do_all iup iupgtk iupmot iupcd iupcontrols iupgl iupglcontrols iup_plot iup_mglplot iup_scintilla iupim iupimglib ledc iupview iuplua5 iupluaconsole iupluascripter iupole iupfiledlg iupweb iuptuio iuptest clean clean-target clean-obj clean-all
#do_all: iup iupcd iupcontrols iupgl iupglcontrols iup_plot iup_mglplot iup_scintilla iupim iupimglib $(WINLIBS) iupweb iuptuio ledc iupview iuplua5 iupluaconsole iupluascripter

MODS = iup iupgtk iupcd iupcontrols iupgl iupglcontrols iup_plot iup_mglplot iup_scintilla iupim iupimglib $(WINLIBS) iuptuio ledc iupview iuplua5 iuptest
# leu: issue with linking bundle .so lib to application
MODS_NOT_WORKING = iupluaconsole iupluascripter

DIRS = src srccd srccontrols srcplot srcmglplot srcscintilla srcgl srcglcontrols srcim srcfiledlg srcweb srctuio srcimglib srclua5 srcluaconsole srcluascripter srcledc srcview test

do_all: $(MODS)

#iup iupgtk iupmot:
#	@$(MAKE) --no-print-directory -C ./src/ $@
iup iupgtk iupmot:
	@$(MAKE) --no-print-directory -C ./src/ $@
iupcd:
	@$(MAKE) --no-print-directory -C ./srccd/
iupcontrols:
	@$(MAKE) --no-print-directory -C ./srccontrols/
iup_plot:
	@$(MAKE) --no-print-directory -C ./srcplot/
iup_mglplot:
	@$(MAKE) --no-print-directory -C ./srcmglplot/
iup_scintilla:
	@$(MAKE) --no-print-directory -C ./srcscintilla/
iupgl:
	@$(MAKE) --no-print-directory -C ./srcgl/
iupglcontrols:
	@$(MAKE) --no-print-directory -C ./srcglcontrols/
iupim:
	@$(MAKE) --no-print-directory -C ./srcim/
iupole:
	@$(MAKE) --no-print-directory -C ./srcole/
iupfiledlg:
	@$(MAKE) --no-print-directory -C ./srcfiledlg/
iupweb:
	@$(MAKE) --no-print-directory -C ./srcweb/
iuptuio:
	@$(MAKE) --no-print-directory -C ./srctuio/
iupimglib:
	@$(MAKE) --no-print-directory -C ./srcimglib/
iuplua5:
	@$(MAKE) --no-print-directory -C ./srclua5/
iupluaconsole:
	@$(MAKE) --no-print-directory -C ./srcluaconsole/
iupluascripter:
	@$(MAKE) --no-print-directory -C ./srcluascripter/

ledc:
	@$(MAKE) --no-print-directory -C ./srcledc/
iupview: iupcontrols iup
	@$(MAKE) --no-print-directory -C ./srcview/
iuptest:
	@$(MAKE) --no-print-directory -C ./test/

.PHONY: clean clean-target clean-obj

clean clean-target clean-obj install-app:
	for i in $(DIRS); \
	do \
	  cd $$i; $(MAKE) -f ../tecmake.mak $@; cd ..; \
	done

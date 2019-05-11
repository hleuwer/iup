ifeq ($(OS), Windows_NT)
  WINLIBS = iupole iupfiledlg
endif

.PHONY: do_all iup iupgtk iupmot iupcd iupcontrols iupgl iupglcontrols iup_plot iup_mglplot iup_scintilla iupim iupimglib ledc iupview iuplua5 iupluaconsole iupluascripter iupole iupfiledlg iupweb iuptuio iuptest clean clean-target clean-obj clean-all
#do_all: iup iupcd iupcontrols iupgl iupglcontrols iup_plot iup_mglplot iup_scintilla iupim iupimglib $(WINLIBS) iupweb iuptuio ledc iupview iuplua5 iupluaconsole iupluascripter

MODS = iup iupgtk iupcd iupcontrols iupgl iupglcontrols iup_plot iup_mglplot iup_scintilla iupim iupimglib $(WINLIBS) iuptuio ledc iupview iuplua5 iuptest
# leu: issue with linking bundle .so lib to application
MODS_NOT_WORKING = iupluaconsole iupluascripter

SUBDIRS = src srccd srccontrols srcplot srcmglplot srcscintilla srcgl srcglcontrols srcim srcfiledlg srcweb srctuio srcimglib srclua5 srcluaconsole srcluascripter srcledc srcview test

# Installation items
APPS = $(shell cat apps.list)
SLIBS = $(shell cat slib.list)
DLIBS = $(shell cat dlib.list)

# Install destinations
INSTALL_BINDIR = /usr/local/bin
INSTALL_LIBDIR = /usr/local/lib
INSTALL_MODDIR = /usr/local/lib/lua


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

.PHONY: clean clean-target clean-obj install install-app install-slib install-dlib install-mod uninstall install-list

clean clean-target clean-obj:
	@for i in $(SUBDIRS); \
	do \
	  cd $$i; $(MAKE)  -f ../tecmake.mak $@; cd ..; \
	done

install: install-app install-slib install-dlib install-mod

install-app: apps.list
	@echo "Installing applications ..."
	@for i in $(APPS); do cp -f $$i $(INSTALL_BINDIR); done

install-slib: slib.list
	@echo "Installing static libraries ..."
	@for i in $(SLIBS); do cp -f $$i $(INSTALL_LIBDIR); done

install-dlib: dlib.list
	@echo "Installing dynamic libraries ..."
	@for i in $(DLIBS); do cp -f $$i $(INSTALL_LIBDIR); done

install-mod: mods51.list mods52.list mods53.list
	@echo "Installing Lua modules ..."
	@for i in $(shell cat mods51.list); do \
		cp -f lib/MacOS1014/Lua51/lib$$i $(INSTALL_LIBDIR)/lib$$i; \
		ln -f -s $(INSTALL_LIBDIR)/lib$$i $(INSTALL_MODDIR)/5.1/$$i; \
	done
	@for i in $(shell cat mods52.list); do \
		cp -f lib/MacOS1014/Lua52/lib$$i $(INSTALL_LIBDIR)/lib$$i; \
		ln -f -s $(INSTALL_LIBDIR)/lib$$i $(INSTALL_MODDIR)/5.2/$$i; \
	done
	@for i in $(shell cat mods53.list); do \
		cp -f lib/MacOS1014/Lua53/lib$$i $(INSTALL_LIBDIR)/lib$$i; \
		ln -f -s $(INSTALL_LIBDIR)/lib$$i $(INSTALL_MODDIR)/5.3/$$i; \
	done

install-list:
	@echo "Generating installation item lists ..."
	@find . -name "*.dylib" > dlib.list
	@cd lib/MacOS1014/Lua51 && ls *.so | sed -s s/lib//1 > ../../../mods51.list
	@cd lib/MacOS1014/Lua52 && ls *.so | sed -s s/lib//1 > ../../../mods52.list
	@cd lib/MacOS1014/Lua53 && ls *.so | sed -s s/lib//1 > ../../../mods53.list
	@find bin/MacOS1014 -type f > apps.list
	@find . -name "*.a" > slib.list

uninstall-app:
	@for i in $(APPS); do rm $(INSTALL_BINDIR)/`basename $$i`; done

uninstall-slib:
	@for i in $(SLIBS); do rm $(INSTALL_LIBDIR)/`basename $$i`; done

uninstall-dlib:
	@for i in $(DLIBS); do rm $(INSTALL_LIBDIR)/`basename $$i`; done

uninstall-mod:
	@for i in $(shell cat mods51.list); do rm $(INSTALL_MODDIR)/5.1/$$i $(INSTALL_LIBDIR)/lib$$i; done
	@for i in $(shell cat mods52.list); do rm $(INSTALL_MODDIR)/5.2/$$i $(INSTALL_LIBDIR)/lib$$i; done
	@for i in $(shell cat mods53.list); do rm $(INSTALL_MODDIR)/5.3/$$i $(INSTALL_LIBDIR)/lib$$i; done

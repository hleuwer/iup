ifeq ($(OS), Windows_NT)
  WINLIBS = iupole iupfiledlg
endif

TEC_UNAME=$(shell ls bin)

.PHONY: do_all iup iupgtk iupmot iupcd iupcontrols iupgl iupglcontrols iup_plot iup_mglplot iup_scintilla iupim iupimglib ledc iupview iuplua5 iupluaconsole iupluascripter iupole iupfiledlg iupweb iuptuio iuptest clean clean-target clean-obj clean-all
#do_all: iup iupcd iupcontrols iupgl iupglcontrols iup_plot iup_mglplot iup_scintilla iupim iupimglib $(WINLIBS) iupweb iuptuio ledc iupview iuplua5 iupluaconsole iupluascripter

MODS = iup iupgtk iupcd iupcontrols iupgl iupglcontrols iup_plot iup_mglplot iup_scintilla iupim iupimglib $(WINLIBS) iuptuio ledc iuplua5 iuptest iupview
# leu: issue with linking bundle .so lib to application
MODS_NOT_WORKING = iupluaconsole iupluascripter

SUBDIRS = src srccd srccontrols srcplot srcmglplot srcscintilla srcgl srcglcontrols srcim srcfiledlg srcweb srctuio srcimglib srclua5 srcluaconsole srcluascripter srcledc srcview test

# Installation items
APPS = $(shell cat apps.list)
SLIBS = $(shell cat slib.list)
DLIBS = $(shell cat dlib.list)
INCS = $(shell cat inc.list)

# Install destinations
INSTALL_DIR = /usr/local
INSTALL_BINDIR = $(INSTALL_DIR)/bin
INSTALL_LIBDIR = $(INSTALL_DIR)/lib
INSTALL_MODDIR = $(INSTALL_DIR)/lib/lua
INSTALL_INCDIR = $(INSTALL_DIR)/include

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

.PHONY: clean clean-target clean-obj install install-app install-slib install-dlib install-mod uninstall install-list tec_uname info sysinfo install-inc

clean clean-target clean-obj:
	@for i in $(SUBDIRS); \
	do \
	  cd $$i; $(MAKE)  -f ../tecmake.mak $@; cd ..; \
	done

install: install-app install-slib install-dlib install-mod install-inc

install-inc: inc.list
	@echo "Installing headers ..."
	@mkdir -p $(INSTALL_INCDIR)/cd
	@for i in $(INCS); do cp -f include/$$i $(INSTALL_INCDIR)/iup; done

install-app: apps.list
	@echo "Installing applications ..."
	@for i in $(APPS); do cp -f $$i $(INSTALL_BINDIR); done

install-slib: slib.list
	@echo "Installing static libraries ..."
	@for i in $(SLIBS); do cp -f $$i $(INSTALL_LIBDIR); done

install-dlib: dlib.list
	@echo "Installing dynamic libraries ..."
	@for i in $(DLIBS); do cp -f $$i $(INSTALL_LIBDIR); done

sysinfo:
	@cd ./src && $(MAKE) -f ../tecmake.mak sysinfo

info:
	@echo "TEC_UNAME   = "$(TEC_UNAME)
	@echo "TEC_SYSNAME = "$(TEC_SYSNAME)
	@echo "Modules:"
	@for i in $(shell cat mods52.list); do \
		echo "   "$$i; \
	done
install-mod: mods52.list mods53.list
	@echo "Installing Lua modules ..."	
#	@mkdir -p $(INSTALL_MODDIR)/5.2
#	@for i in $(shell cat mods51.list); do \
#		mkdir -p $(INSTALL_MODDIR)/5.1 \
#		cp -f lib/$(TEC_UNAME)/Lua51/lib$$i $(INSTALL_LIBDIR)/lib$$i; \
#		ln -f -s $(INSTALL_LIBDIR)/lib$$i $(INSTALL_MODDIR)/5.1/$$i; \
#	done
	@mkdir -p $(INSTALL_MODDIR)/5.2
	@for i in $(shell cat mods52.list); do \
		cp -f lib/$(TEC_UNAME)/Lua52/lib$$i $(INSTALL_LIBDIR)/lib$$i; \
		ln -f -s $(INSTALL_LIBDIR)/lib$$i $(INSTALL_MODDIR)/5.2/$$i; \
	done
	@mkdir -p $(INSTALL_MODDIR)/5.3 
	@for i in $(shell cat mods53.list); do \
		cp -f lib/$(TEC_UNAME)/Lua53/lib$$i $(INSTALL_LIBDIR)/lib$$i; \
		ln -f -s $(INSTALL_LIBDIR)/lib$$i $(INSTALL_MODDIR)/5.3/$$i; \
	done

tec_uname:
	@echo $(TEC_UNAME) > tec_uname.txt

install-list:
	@echo "Generating installation item lists ..."
	@ls include > inc.list
ifeq (Linux, $(TEC_SYSNAME))
	@find . -name "*.so" > dlib.list
endif
ifeq (MacOS, $(TEC_SYSNAME))
	@find . -name "*.dylib" > dlib.list
endif
#	@cd lib/$(TEC_UNAME)/Lua51 && ls *.so | sed -s s/lib//1 > ../../../mods51.list
	@cd lib/$(TEC_UNAME)/Lua52 && ls *.so | sed -s s/lib//1 > ../../../mods52.list
	@cd lib/$(TEC_UNAME)/Lua53 && ls *.so | sed -s s/lib//1 > ../../../mods53.list
	@find bin/$(TEC_UNAME) -type f > apps.list
	@find . -name "*.a" > slib.list
	@echo $(TEC_UNAME) > tec_uname.txt

uninstall-app:
	@for i in $(APPS); do rm $(INSTALL_BINDIR)/`basename $$i`; done

uninstall-slib:
	@for i in $(SLIBS); do rm $(INSTALL_LIBDIR)/`basename $$i`; done

uninstall-dlib:
	@for i in $(DLIBS); do rm $(INSTALL_LIBDIR)/`basename $$i`; done

uninstall-mod:
#	@for i in $(shell cat mods51.list); do rm $(INSTALL_MODDIR)/5.1/$$i $(INSTALL_LIBDIR)/lib$$i; done
	@for i in $(shell cat mods52.list); do rm $(INSTALL_MODDIR)/5.2/$$i $(INSTALL_LIBDIR)/lib$$i; done
	@for i in $(shell cat mods53.list); do rm $(INSTALL_MODDIR)/5.3/$$i $(INSTALL_LIBDIR)/lib$$i; done


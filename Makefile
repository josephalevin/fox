#!/bin/make
#
include arch.make
#
default: objsdir $(BUILD_TARGETS) examples_build
	touch .FoX
#
objsdir:
	mkdir -p objs/lib objs/finclude
#
examples_build: wxml_lib wcml_lib sax_lib dom_lib
	(cd examples; make)
#
check: dom_check sax_check wxml_check wcml_check
#---------------------------
INCFLAGS=-Iobjs/finclude
#
#
# Recursive make for each module
#
dom_lib: objsdir sax_lib wxml_lib
	(cd dom; $(MAKE))
dom_lib_clean:
	(cd dom; $(MAKE) clean)
#
sax_lib: objsdir common_lib fsys_lib
	(cd sax; $(MAKE))
sax_lib_clean:
	(cd sax; $(MAKE) clean)
#
wxml_lib: objsdir common_lib fsys_lib 
	(cd wxml; $(MAKE))
wxml_lib_clean:
	(cd wxml; $(MAKE) clean)
#
wcml_lib: objsdir utils_lib wxml_lib
	(cd wcml; $(MAKE))
wcml_lib_clean: 
	(cd wcml; $(MAKE) clean)
#
common_lib: objsdir fsys_lib
	(cd common; $(MAKE))
common_lib_clean:
	(cd common; $(MAKE) clean)
#
utils_lib: objsdir
	(cd utils; $(MAKE))
utils_lib_clean:
	(cd utils; $(MAKE) clean)
#
fsys_lib: objsdir
	(cd fsys; $(MAKE))
fsys_lib_clean:
	(cd fsys; $(MAKE) clean)
#
#
# Unit tests (where implemented)
#
fsys_check:
#
common_check:
	(cd common/test;./run_tests.sh)
#
utils_check:
#
dom_check:
#
sax_check:
#
wcml_check:
	(cd wcml/test;./run_tests.sh)
#
wxml_check:
	(cd wxml/test;./run_tests.sh)
#
check: common_check wxml_check wcml_check sax_check dom_check
#
#
# Documentation
#
DoX:
	(cd DoX; make)
#
#
# Clean
#
clean: wxml_lib_clean wcml_lib_clean common_lib_clean fsys_lib_clean sax_lib_clean dom_lib_clean utils_lib_clean
	(cd examples;make clean)
	rm -rf objs .FoX
#
distclean: clean
	rm -f FoX-config arch.make config.log config.status .config

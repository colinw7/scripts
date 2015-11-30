if ($?LOGIN_RUN == 1) goto end_login

setenv DEV_DIR $home/dev

setenv BIN_DIR $home/bin
setenv LIB_DIR $home/lib
setenv OBJ_DIR $home/obj

setenv PROGS_DIR $DEV_DIR/progs
setenv INC_DIR   $DEV_DIR/progs/include
setenv SRC_DIR   $DEV_DIR/progs/src
setenv TEST_DIR  $DEV_DIR/progs/test

setenv SCRIPT_DIR $DEV_DIR/script

set path = (. $BIN_DIR $SCRIPT_DIR)
set path = ($path /bin /usr/bin /usr/bin/X11)
set path = ($path /usr/local/bin)

setenv EDITOR vi

setenv COLOUR_XTERM 1

setenv XAPPLRESDIR $home/data/resources

#setenv TMPDIR /usr/tmp

setenv MY_TMP_DIR /tmp

setenv CDOC_PROG_OPTS '-iconbar -noshowheader -noshowfooter'
setenv CDOC_SCRIPT_OPTS '-pg yes -r 85'
setenv CDOC_PRINT_COMMAND 'ghostview %s'

setenv CWM_IMAGE_PATH "$home/progs/winmgr/data/cwm/images:$home/progs/image/data/ximage:/usr/include/X11/bitmaps"

setenv CFM_IMAGE_PATH "$home/data/cfm"

#setenv LD_LIBRARY_PATH $home/lib

#setenv MANPATH '/usr/man:/usr/man/preformat:/usr/X11R6/man:/usr/man/allman'

setenv TEST_BIN_DIR $BIN_DIR/test

setenv RR_INC_DIR $DEV_DIR/work/rr/include
setenv RR_LIB_DIR $DEV_DIR/work/rr/lib
setenv RR_BIN_DIR $DEV_DIR/work/rr/bin

setenv MAKE_DIR $DEV_DIR/make

setenv X11_INC_DIR /usr/X11R6/include
setenv XM_INC_DIR /usr/X11R6/include

setenv X11_LIB_DIR /usr/X11R6/lib
setenv XM_LIB_DIR /usr/X11R6/lib

setenv XM_LIBS '-lXm -lXt -lX11 -lXp -lXext'
setenv X11_LIBS '-lXt -lX11 -lXext'

setenv IMAGE_LIBS '-lpng -ljpeg'

setenv XIMAGE_LIBS '-lximage -lpng -ljpeg -lz'

setenv TCL_LIBS '-ltix -ltk -ltcl'

set dollar = '$'

setenv DIRFMT "\
$BIN_DIR=${dollar}{BIN_DIR} \
$LIB_DIR=${dollar}{LIB_DIR} \
$OBJ_DIR=${dollar}{OBJ_DIR} \
$INC_DIR=${dollar}{INC_DIR} \
$SRC_DIR=${dollar}{SRC_DIR} \
$TEST_DIR=${dollar}{TEST_DIR} \
$SCRIPT_DIR=${dollar}{SCRIPT_DIR} \
$PROGS_DIR=${dollar}{PROGS_DIR} \
$home=~"

setenv CSPELL_DIR $PROGS_DIR/spell/data/CSpell

stty erase ^h kill ^u intr ^c susp ^z stop ^s start ^q quit "^\\"

setenv HU51_MAKEFILE_INCLUDE_PATH $DEV_DIR/work/rr/data

setenv LOGIN_RUN 1

setenv C_FULLWARN '-pedantic -W -Wall -Wstrict-prototypes -Wmissing-prototypes'
setenv CPP_FULLWARN '-pedantic -W -Wall'

# if ($?DISPLAY == 0) startx >& /dev/null

if (! -e /tmp/CCeil) then
  rm -f /tmp/CCeil

  ln -s $BIN_DIR/CCeil /tmp/CCeil
endif

end_login:

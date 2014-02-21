extproc sh
#
#
_srcdir=`pwd`
CONFIG_SITE=${_srcdir}/os2/config.site
export CONFIG_SITE
#
#
# os2config version 1.5  by Jun SAWATAISHI <jsawa@attglobal.net>
# 
#   Purpose: Rewrite scripts (configure ...) and Makefile.in's 
#            to run configure and make WITHOUT AUTOCONF. 
# 
# @@@ Required Executables @@@
# 
#   HOBBES=ftp://hobbes.nmsu.edu/pub/os2
#   LEO=ftp://ftp.leo.org/pub/comp/os/os2/leo
#   JSAWA=http://www2s.biglobe.ne.jp/~vtgf3mpr
# 
#  GNU find (find.exe)
#      LEO/gnu/systools/gnufind.zip   ; v4.1
#      HOBBES/util/disk/gnufind.zip   ; v4.1
#  GNU sed 
#      JSAWA/gnu/sed.htm              ; v3.02.80
# 
#  GNU grep (grep.exe)
#      HOBBES/util/file/gnugrep.zip    ; v2.0
#      LEO/gnu/systools/gnugrep.zip    ; v2.0 
#      JSAWA/gnu/grep.htm              ; v2.3h or later
# 
#  GNU text utilities (cat,cut, head)  ;
#     LEO/gnu/systools/gnututil.zip    ; v1.19
#     HOBBES/util/file/gnututil.zip    ; v1.19
#     JSAWA/gnu/text-util.htm          ; v2.0 or later
#
#  file - determine file type          ; v3.30
#      JSAWA/os2unix/file330.zip
#  
#  os2unix utility - tool to modify    ; included in "os2" directory
#      configure, Makefile.in, ....  
#      JSAWA/os2unix/os2unix.zip       ; latest version
# #####################################################################
add_arg=' '
prefix__=' '
__HOSTNAME=i386-pc-os2-emx

function show_help
{
echo "\tStep 1 - modify configure, Makefile.in's, and scripts with \`os2unix'"
echo "\tStep 2 - run configure according to one of three arguments below\n"
echo " os2config DIR [intl]  : for non-XFree86 program "
echo "           configure --prefix=DIR --mandir=DIR/share/man"
echo "                     --infodir=DIR/share/man\n"
echo "           specify DIR where you want to install\n"
echo " os2config auto [intl] : for non-XFree86 program "
echo "           if UNIXROOT environment variable is already set,"
echo "           you may choose this option.\n"
echo '           configure --prefix=${UNIXROOT}/usr --mandir=${UNIXROOT}/usr/share/man'
echo '                     --infodir=${UNIXROOT}/usr/share/info\n'
echo " os2config x [intl]    : for XFree86 program"
echo '            configure --prefix=${X11ROOT}/XFree86'
echo '                      --datadir=${X11ROOT}/XFree86/lib/X11\n'
echo "    Add the second argument \"intl\", if you'd like to link programs"
echo "    with gettext library included in source."
   if grep DESTDIR Makefile >nul ; then
      echo "@@@NOTE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n"
      echo " Makefile supports DESTDIR !\n"
      echo "  Do not use drive letter for DIR(prefix). \n"
      echo " Please try again. \n\n"
      exit 0
   fi
}

function do_os2unix
{
  if [ ! -f 00os2unix_done.tmp ] ; then
    if ! os2unix -check ; then
      echo "\n\t Stopped because some utilities cannot be run"
      exit 1
    fi
    os2unix -all
    os2unix -clean
    touch 00os2unix_done.tmp
  else
    echo "\n\tos2unix was already executed\n"
  fi
}

function do_patch
{
  if [ ! -f 00patch_done.tmp ] ; then
    if [ -f os2/C_Source.diff ]; then  patch -p1 < os2/C_Source.diff ; fi
    if [ -f os2/In-make.diff ] ; then  patch -p1 < os2/In-make.diff  ; fi
    if [ -f os2/Other.diff ]   ; then  patch -p1 < os2/Other.diff    ; fi
    touch 00patch_done.tmp
    touch configure
  else
    echo "\n\tDiff files have already been applied\n"
  fi
  if [ -d intl ] ; then 
    if ! grep __EMX__ intl/bindtextdom.c >nul  ; then
      add_arg=''
      echo "\n\tGettext source has no OS/2 code."
      echo "\tIncluded gettext is not used\n"
    fi
  else
      echo "\n\tThere's no gettext source.\n"
  fi

 if [ -f os2configure.cmd ] ; then 
   echo "-------------------------------------------------------------"
   echo "Recommendation!"
   echo "    You had better run \`os2configure.cmd\', because this "
   echo "    script will give proper argument to configure script.  "
   echo "-------------------------------------------------------------"
   exit 0
 fi
 if [ -f os2configure_make.cmd ] ; then 
   echo "-------------------------------------------------------------"
   echo "Recommendation!"
   echo "    You had better run \`os2configure_make.cmd\', because this "
   echo "    script will give proper argument to configure script.  "
   echo "-------------------------------------------------------------"
   exit 0
 fi
}

function do_config
{
  echo "configure --prefix=${prefix__} --mandir=${prefix__}/share/man"
  echo "          --infodir=${prefix__}/share/info ${add_arg}"
  echo "          --host=${__HOSTNAME}"
  echo "   ......................................................."
if [ -f ./configure ] ; then 
  ./configure --prefix=${prefix__} --mandir=${prefix__}/share/man \
               --infodir=${prefix__}/share/info ${add_arg}\
               --host=${__HOSTNAME}
else
	echo "\n\nWarnig: no configure script in top directory. "
	exit 0
fi
}

function x_config
{
  echo "configure --prefix=${X11ROOT}/XFree86"
  echo "          --datadir=${X11ROOT}/XFree86/lib/X11 $add_arg"
  echo "          --host=${__HOSTNAME}"
  echo "   ......................................................."

if [ -f ./configure ] ; then 
  ./configure --prefix="${X11ROOT}/XFree86" \
              --datadir="${X11ROOT}/XFree86/lib/X11 ${add_arg}"\
              --host=${__HOSTNAME}
else
	echo "\n\nWarnig: no configure script in top directory. "
	exit 0
fi
}


if [ -z $1 ]; then
  show_help
  exit 0
fi
if [ "$2" = "intl" ]; then
    add_arg=--with-included-gettext
else
    echo "\n\tNo gettext source!"
fi

case "$1" in
  x)
      if [ -n "${X11ROOT}" ]; then
        do_os2unix
        do_patch
        x_config
      else
        echo "Error: set X11ROOT env. var.!!"
        exit 1
      fi
      ;;
  auto)
      if [ -n "${UNIXROOT}" ]; then
        prefix__="${UNIXROOT}/usr"
        do_os2unix
        do_patch
        do_config
      else
        echo "Error: set UNIXROOT env. var.!!"
        exit 1
      fi
      ;;
  /*|[a-zA-Z]:/*)
   if grep DESTDIR Makefile >nul ; then
      echo "@@@NOTE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n"
      echo " Makefile supports DESTDIR !\n"
      echo "  Do not use drive letter for prefix. \n"
      echo " Please try again. \n\n"
      exit 0
    else
      prefix__="$1"
      do_os2unix
      do_patch
      do_config
   fi
      ;;
  *)
      echo "Error: first argument \"$1\" is not recognized"
      exit 1
      ;;
esac
exit 0
# EOF

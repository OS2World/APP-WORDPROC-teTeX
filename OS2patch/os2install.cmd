extproc sh.exe
#
if [ -z "$1" ] ; then
  echo "Usage:os2install [unixroot|x:/foo/bar|[a-z]:] [do]\n"
  echo "\n"
  echo "  Second argument must be 'do' if really do install\n"
  echo "<a> os2install unixroot do"
  echo "   if UNIXROOT env. var. is set files will be installed \n"
  echo "     in UNIXROOT/usr/{bin,etc,lib,include,share/{man,info,lib}}..\n"
  echo "<b> os2install DRIVE_NAME do [NOTE: two letters from 'a:' to 'z:']\n"
  echo "     if DRIVE_NAME is specified, target drive is set as DRIVE_NAME\n"
  echo "<b> os2install DIR_NAME do\n"
  echo "     if DIR_NAME is specified, target directory is set as DIR_NAME\n"
  echo "\n"
fi
dest_dir=
drive=
UNIXROOT=
_destdir=no
inc_dir=/emx/include
lib_dir=/emx/lib
#
if [ -n "$1" ] ; then
  case "$1" in
    unixroot)
      UNIXROOT=$1
      ;;
    [A-Za-z]:/*)
      drive=$1
      ;;
    [A-Za-z]:)
      UNIXROOT=$1
      drive=$1
      ;;
  esac
  shift
fi


if find . -iname Makefile |xargs grep DESTDIR >nul ; then
  _destdir=yes
fi
echo "_destdir=$_destdir" 
if [ ${_destdir} = "yes" ]  ; then
  echo "DESTDIR is supported in this source tree"
  if [ -n "$UNIXROOT" ]; then
    dest_dir="${UNIXROOT}"
    drive=
  else
    if [ -n "$drive" ] ; then
      dest_dir=$drive
    else
      if [ -n "$C_INCLUDE_PATH" ] ; then
        dest_dir=`echo "$C_INCLUDE_PATH" | sed -n -e 's@^\([a-zA-Z]:\).*$@\1@p'`
      fi
    fi
  fi
else
  if [ -n "$drive" ] ; then
      lib_dir=${drive}/usr/lib
      inc_dir=${drive}/usr/include
  else
    if [ -n "$C_INCLUDE_PATH" ] ; then
      drive=`echo "$C_INCLUDE_PATH" | sed -n -e 's@^\([a-zA-Z]:\).*$@\1@p'`
      lib_dir=${LIBRARY_PATH:-${drive}/emx/lib}
      inc_dir=${C_INCLUDE_PATH:-${drive}/emx/include}
    fi
  fi
echo "DESTDIR is not supported in this source tree"
fi
	echo "\n@ dest_dir=$dest_dir"
	echo "@ lib_dir=$lib_dir"
	echo "@ inc_dir=$inc_dir"
	echo "@ drive=$drive\n"
	echo "@ make install $* ...."
echo make install MAKE=make $* DESTDIR=$dest_dir  prefix=${drive}/usr bindir=${drive}/usr/bin    libdir=${lib_dir}    includedir=${inc_dir}    mandir=${drive}/usr/share/man    infodir=${drive}/usr/share/info    datadir=${drive}/usr/share    localedir=${drive}/usr/share/locale    htmldir=${drive}/usr/share/doc/`pwd | sed -e "s@^.*/\([^/]\+\)-os2.*@\1@"`
if [ ! "$1" = "do" ] ; then
 exit 0
else
  shift
fi

make install MAKE=make $* DESTDIR=$dest_dir  prefix=${drive}/usr bindir=${drive}/usr/bin    libdir=${lib_dir}    includedir=${inc_dir}    mandir=${drive}/usr/share/man    infodir=${drive}/usr/share/info    datadir=${drive}/usr/share    localedir=${drive}/usr/share/locale    htmldir=${drive}/usr/share/doc/`pwd | sed -e "s@^.*/\([^/]\+\)-os2.*@\1@"` 2>&1 |tee log

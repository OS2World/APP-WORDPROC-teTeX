#!sed -f
#
#  This script was wrote by SAWATAISHI Jun <jsawa@attglobel.net>
#
#
2i\
PATH=`cmd.exe /c "echo %PATH%" | sed -e 's@\\\\\\\\@/@g'`\
export $PATH\
INSTALL=`type install.exe|sed -e 's@\\\\\\\\@/@g' -e 's@.* @@'`\
RANLIB=echo\
MAKE=make\
SHELL=sh\
MAKE=make\
ac_cv_host=i386-pc-gnu\
CC=gcc\
CXX=gcc\
YACC='bison -y'\
AWK=gawk\
LEX=flex\
cross_compiling=no\
PRINTABLE_OS_NAME=\"OS\/2\"\
ac_exeext=.exe\
ac_cv_exeext=.exe\
BMTYPE=int\
BMBYTES=4\
CFLAGS='-D__EMX__ -DOS2 -Zmtd -D__ST_MT_ERRNO__ -O2 '\
CXXFLAGS='-D__EMX__ -DOS2 -Zmtd -D__ST_MT_ERRNO__ -O2 '\
LDFLAGS='-Zmtd -D__ST_MT_ERRNO__ -O2 -s -Zsysv-signals -Zstack 512 '\
ac_cv_c_bigendian=no\
ac_cv_path___CHGRP=echo\
ac_cv_path___CHOWN=echo\
ac_cv_path___RSH=echo
#
s@^\(cache_file=\).*$@\1./config.cache@
s@/bin/sh@sh.exe@
s/^.*MYPATH=\".*$/MYPATH=\"$PATH\"/
s/\-lintl/\-llibintl/g
s@DATADIRNAME=lib@DATADIRNAME=share@
s/ ln \-s / cp.exe -p /
s@^ac_default_prefix=.*$@ac_default_prefix=/usr@
s@^prefix=.*$@prefix=/usr@
s@^ac_given_srcdir=.*@ac_given_srcdir=\`pwd \| sed \-e \"s/\^\.://\"\`@
s@^srcdir=.*@srcdir=\`pwd \| sed \-e \"s/\^\.://\"\`@
s/IFS=\":\"$/IFS=";"/
#s/^ *\(\/\*)\)$/  [a-zA-Z]:*|*)/
s@^\( */\*\))@\1|[a-zA-Z]:[\\/]*)@
s@\$ac_dir/\$ac_word@$ac_dir/${ac_word}.exe@
s/^ac_exeext=$/ac_exeext=.exe/
s/^x_includes=NONE/x_includes='$\{X11ROOT\}\/XFree86\/include'/
s/^x_libraries=NONE/x_libraries='$\{X11ROOT\}\/XFree86\/lib'/
###################################################################
# If LDFLAG do NOT have ``-Zexe'' uncomment the next two lines
s/conftest /conftest${ac_exeext} /g
s/conftest;/conftest${ac_exeext};/g
#s/conftest /conftest.exe /g
#s/conftest;/conftest.exe;/g
###################################################################
s/"${IFS}:"/"${IFS};"/
s/ac_confdir=`echo .*/ac_confdir=\`echo \$ac_prog\|sed -e \'s%\/\[\^\/\]\[\^\/\]\*\$%%\' -e \'s%\^\.\:%%\'\`/
s/\$LN_S%g$/cp.exe -p%g/
s%/bin/sh%sh%g
s%/usr/bin/uname%uname%g
s%/bin/uname%uname%g
s%/bin/rm%rm%g
s/ac_cv_prog_cc_cross=yes/ac_cv_prog_cc_cross=no/
s/^host=NONE$/host=i386-pc-gnu/
s@^prefix=NONE$@prefix=/usr@
s@^exec_prefix=NONE$@exec_prefix=/usr@
### EOF ######################################################################


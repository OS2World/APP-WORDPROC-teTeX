s/INSTALL = :/INSTALL = /
s/INSTALL = @INSTALL@/INSTALL = install.exe/
s@/bin/sh@sh@
s@/bin/rm@rm@
s@/bin/ln@cp@
s@/bin/ls@ls@
s@/bin/cp@cp@
s/@PROG_EXT@/.exe/
s/PATH=\(.*\):\$\$PATH\(.*\)$/PATH="\1;$$PATH"\2/
s/@:/ /
s@= \$(top_srcdir)/mkinstalldirs@= sh \$(top_srcdir)/mkinstalldirs@
s@LIBTOOL   = ..@LIBTOOL   = sh ..@

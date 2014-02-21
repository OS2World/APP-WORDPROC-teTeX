#n
s/^\([-A-Za-z0-9]\+\)[ \t]\+\([-A-Za-z0-9]\+\)[ \t]\+.*$/\
\#\
\# copy executables according to fmtutil.cnf\
if [ ! \1 = \2 ] ; then\
	if [ -f \2.exe ] ; then\
		cp -vp \2.exe \1.exe\
	fi\
fi/p




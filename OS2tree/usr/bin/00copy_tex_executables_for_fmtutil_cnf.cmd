extproc sh.exe
## using $TEXMF/web2c/fmtutil.cnf
## 
##
echo "Now according to $TEXMF/web2c/fmtutil.cnf make a script to copy executables\n"
sed  -f 00copy_tex_executables_for_fmtutil_cnf.sed $TEXMF/web2c/fmtutil.cnf\
        > 00copy_tex_executables_for_fmtutil_cnf.sh
echo "\n Check 00copy_tex_executables_for_fmtutil_cnf.sh\n"
echo "Execute 00copy.cmd and execute is if needed"




# Source this script to set up the ROOT build that this script is part of.
#
# Conveniently an alias like this can be defined in ~/.cshrc:
#   alias thisroot "source bin/thisroot.sh"
#
# This script if for the csh like shells, see thisroot.sh for bash like shells.
#
# Author: Fons Rademakers, 18/8/2006

set cshPath="/publicfs/dyb/user/lidj/software/root-v6-00/bin/thisroot.csh"

if ($?ROOTSYS) then
   set old_rootsys="$ROOTSYS"
endif

set cshRealPath=`readlink -f ${cshPath}`
if ("$cshRealPath" != "") then
    set thisroot="`dirname $cshRealPath`"
else
    set thisroot="`dirname $cshPath`"
endif

if ($?thisroot) then
setenv ROOTSYS `dirname $thisroot`

if ($?old_rootsys) then
   setenv PATH `echo $PATH | sed -e "s;:$old_rootsys/bin:;:;g" \
                                 -e "s;:$old_rootsys/bin;;g"   \
                                 -e "s;$old_rootsys/bin:;;g"   \
                                 -e "s;$old_rootsys/bin;;g"`
   if ($?LD_LIBRARY_PATH) then
      setenv LD_LIBRARY_PATH `echo $LD_LIBRARY_PATH | \
                             sed -e "s;:$old_rootsys/lib:;:;g" \
                                 -e "s;:$old_rootsys/lib;;g"   \
                                 -e "s;$old_rootsys/lib:;;g"   \
                                 -e "s;$old_rootsys/lib;;g"`
   endif
   if ($?DYLD_LIBRARY_PATH) then
      setenv DYLD_LIBRARY_PATH `echo $DYLD_LIBRARY_PATH | \
                             sed -e "s;:$old_rootsys/lib:;:;g" \
                                 -e "s;:$old_rootsys/lib;;g"   \
                                 -e "s;$old_rootsys/lib:;;g"   \
                                 -e "s;$old_rootsys/lib;;g"`
   endif
   if ($?SHLIB_PATH) then
      setenv SHLIB_PATH `echo $SHLIB_PATH | \
                             sed -e "s;:$old_rootsys/lib:;:;g" \
                                 -e "s;:$old_rootsys/lib;;g"   \
                                 -e "s;$old_rootsys/lib:;;g"   \
                                 -e "s;$old_rootsys/lib;;g"`
   endif
   if ($?LIBPATH) then
      setenv LIBPATH `echo $LIBPATH | \
                             sed -e "s;:$old_rootsys/lib:;:;g" \
                                 -e "s;:$old_rootsys/lib;;g"   \
                                 -e "s;$old_rootsys/lib:;;g"   \
                                 -e "s;$old_rootsys/lib;;g"`
   endif
   if ($?PYTHONPATH) then
      setenv PYTHONPATH `echo $PYTHONPATH | \
                             sed -e "s;:$old_rootsys/lib:;:;g" \
                                 -e "s;:$old_rootsys/lib;;g"   \
                                 -e "s;$old_rootsys/lib:;;g"   \
                                 -e "s;$old_rootsys/lib;;g"`
   endif
   if ($?MANPATH) then
      setenv MANPATH `echo $MANPATH | \
                             sed -e "s;:$old_rootsys/man:;:;g" \
                                 -e "s;:$old_rootsys/man;;g"   \
                                 -e "s;$old_rootsys/man:;;g"   \
                                 -e "s;$old_rootsys/man;;g"`
   endif
endif


if ($?MANPATH) then
# Nothing to do
else
   # Grab the default man path before setting the path to avoid duplicates
   if ( -X manpath ) then
      set default_manpath = `manpath`
   else
      set default_manpath = `man -w`
   endif
endif

set path = ($ROOTSYS/bin $path)

if ($?LD_LIBRARY_PATH) then
   setenv LD_LIBRARY_PATH $ROOTSYS/lib:$LD_LIBRARY_PATH      # Linux, ELF HP-UX
else
   setenv LD_LIBRARY_PATH $ROOTSYS/lib
endif

if ($?DYLD_LIBRARY_PATH) then
   setenv DYLD_LIBRARY_PATH $ROOTSYS/lib:$DYLD_LIBRARY_PATH  # Mac OS X
else
   setenv DYLD_LIBRARY_PATH $ROOTSYS/lib
endif

if ($?SHLIB_PATH) then
   setenv SHLIB_PATH $ROOTSYS/lib:$SHLIB_PATH                # legacy HP-UX
else
   setenv SHLIB_PATH $ROOTSYS/lib
endif

if ($?LIBPATH) then
   setenv LIBPATH $ROOTSYS/lib:$LIBPATH                      # AIX
else
   setenv LIBPATH $ROOTSYS/lib
endif

if ($?PYTHONPATH) then
   setenv PYTHONPATH $ROOTSYS/lib:$PYTHONPATH
else
   setenv PYTHONPATH $ROOTSYS/lib
endif

if ($?MANPATH) then
   setenv MANPATH `dirname $ROOTSYS/man/man1`:$MANPATH
else
   setenv MANPATH `dirname $ROOTSYS/man/man1`:$default_manpath
endif

endif # if ("$thisroot" != "")

set thisroot=
set old_rootsys=


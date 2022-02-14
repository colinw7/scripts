#!/bin/csh -f

set dirs = `grep_src -d -f $* | sort -u`

set dir = .

if      ($#dirs == 0) then
  exit 1
else if ($#dirs == 1) then
  echo $dir > ~/.cimenu
else
  CIMenuTest -border $dirs
endif

exit 0

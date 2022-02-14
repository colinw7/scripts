#!/bin/csh -f

set clean = 0
set args  = ()

while ($#argv > 0)
  if      ("$1" == "-clean") then
    set clean = 1
    shift
  else
    set args = ($args $1:q)
    shift
  endif
end

set np = `CGMatch -q "*.pro" -c`

if      ($np > 0) then
  qmake

  if ($clean == 1) then
    make clean
  else
    make
  endif
else if (-e Makefile) then
  if ($clean == 1) then
    make clean
  else
    make
  endif
else
  echo "No makefile"
endif

exit 0

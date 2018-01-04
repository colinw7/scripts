#!/bin/csh -f

set args = ()
set qt   = 0

while ($#argv > 0)
  if      ("$1" == "-qt") then
    set qt = 1
    shift
  else
    set args = ($args $1)
    shift
  endif
end

if ($qt == 1) then
  CClassGen --include --name $args
else
  CClassGen --qt --include --name $args
endif

exit 0

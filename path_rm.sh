#!/bin/csh -f

set path1 = ()

set rm_path = $1

foreach p ($path)
  if ("$p" == "$rm_path") then
    continue
  endif

  set path1 = ($path1 $p)
end

echo $path1

exit 0

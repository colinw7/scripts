#!/bin/csh -f

source `new_which machine_type`
source `new_which set_colours`

set nonomatch
set noglob

if ($#argv < 2) then
  echo "Usage: rgrep <pattern> [-l] [-w] [-i] [-short] <files>"
  exit 1
endif

set pattern = $1:q
set files   = ($2)

if ($#argv >= 3) then
  set pdir = $3
else
  set pdir = `pwd`
endif

set files1 = ""

if ($MACHINE_TYPE == sun) then
  set gopts = ()
else
  set gopts = "-H"
endif

set ropts = ()

set short = 0
set iopt  = 0
set lopt  = 0

foreach file ($files)
  if      ("$file" == "-i") then
    set gopts = ($gopts -i)
    set iopt  = 1
  else if ("$file" == "-l") then
    set gopts = ($gopts -l)
    set lopt  = 1
  else if ("$file" == "-w") then
    set gopts = ($gopts -w)
  else if ("$file" == "-il") then
    set gopts = ($gopts -il)
    set iopt  = 1
    set lopt  = 1
  else if ("$file" == "-li") then
    set gopts = ($gopts -il)
    set iopt  = 1
    set lopt  = 1
  else if ("$file" == "-iw") then
    set gopts = ($gopts -iw)
    set iopt  = 1
  else if ("$file" == "-wi") then
    set gopts = ($gopts -iw)
    set iopt  = 1
  else if ("$file" == "-lw") then
    set gopts = ($gopts -lw)
    set lopt  = 1
  else if ("$file" == "-wl") then
    set gopts = ($gopts -lw)
    set lopt  = 1
  else if ("$file" == "-ilw") then
    set gopts = ($gopts -ilw)
    set iopt  = 1
    set lopt  = 1
  else if ("$file" == "-iwl") then
    set gopts = ($gopts -ilw)
    set iopt  = 1
    set lopt  = 1
  else if ("$file" == "-liw") then
    set gopts = ($gopts -ilw)
    set iopt  = 1
    set lopt  = 1
  else if ("$file" == "-lwi") then
    set gopts = ($gopts -ilw)
    set iopt  = 1
    set lopt  = 1
  else if ("$file" == "-wil") then
    set gopts = ($gopts -ilw)
    set iopt  = 1
    set lopt  = 1
  else if ("$file" == "-wli") then
    set gopts = ($gopts -ilw)
    set iopt  = 1
    set lopt  = 1
  else if ("$file" == "-short") then
    set short = 1
    set ropts = ($ropts -short)
  else
    unset noglob
    set   file1 = `echo $file`
    set   noglob

    if ("$file1" != "$file") then
      set files1 = ($files1 $file1)
    endif
  endif
end

if ("$files1" != "") then
  set temp_file =  $MY_TMP_DIR/rgrep.$$

  grep $gopts $pattern:q $files1 > $temp_file

  if (! -z $temp_file) then
    if ($short == 1 && $lopt == 1) then
      cat $temp_file | sed "s@^@$pdir/@"
    else
      if ($lopt != 1) then
        echo "---- ${yellow}${pdir}${norm} ----"

        if ($iopt != 1) then
          cat $temp_file | grep --color $pattern:q
        else
          cat $temp_file | grep --color -i $pattern:q
        endif
      else
        cat $temp_file | sed "s@^@$pdir/@"
      endif
    endif
  endif

  rm -f $temp_file
endif

unset noglob

set d = `pwd`

foreach dir (*)
  if ("$dir" == "*") continue

  if (! -d $dir) continue

  is_link $dir

  if ($status == 1) continue

  cd $dir

  rgrep.csh $pattern:q "$files" $d/$dir

  cd $d
end

exit 0

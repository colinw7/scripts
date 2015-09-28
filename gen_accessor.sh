#!/bin/csh -f

set type = ''
set name = ''
set ptr  = 0
set args = ()

while ($#argv > 0)
  if      ("$1" == "-p") then
    set ptr = 1
    shift
  else if ("$type" == "") then
    set type = $1
    shift
  else if ("$name" == "") then
    set name = $1
    shift
  else
    set args = ($args $1)
    shift
  endif
end

if ("$name" == "" || "$type" == "") then
  echo "Usage: gen_accessor.sh [-p] <type> <name>"
  exit 1
endif

set basic = 0

if ("$type" == "bool" || "$type" == "int" || "$type" == "double") then
  set basic = 1
endif

set name1 = `echo $name | sed "s/\(.*\)_/\1/"`
set name2 = `echo $name1 | sed "s/\([a-z]\)/\U\1/"`

set var = "${name1}_"

set setter = "set${name2}"
set getter = "${name1}"

if ($ptr == 0) then
  set tmpVar = "v";
else
  set tmpVar = "p";
endif

if ($basic == 1) then
  if ($type == "bool") then
    set getter = "is${name2}"
    set tmpVar = "b";
  else if ($type == "int") then
    set tmpVar = "i";
  else if ($type == "double") then
    set tmpVar = "r";
  else if ($type == "std::string" || $type == "string") then
    set tmpVar = "s";
  endif

  if ($ptr == 0) then
    echo "  ${type} ${getter}() const { return ${var}; }"
    echo "  void ${setter}(${type} ${tmpVar}) { ${var} = ${tmpVar}; }"
  else
    echo "  const ${type} *${getter}() const { return ${var}; }"
    echo "  void ${setter}(${type} *${tmpVar}) { ${var} = ${tmpVar}; }"
  endif
else
  if ($ptr == 0) then
    echo "  const ${type} &${getter}() const { return ${var}; }"
    echo "  void ${setter}(const ${type} &${tmpVar}) { ${var} = ${tmpVar}; }"
  else
    echo "  const ${type} *${getter}() const { return ${var}; }"
    echo "  void ${setter}(${type} *${tmpVar}) { ${var} = ${tmpVar}; }"
  endif
endif

exit 0

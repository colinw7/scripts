#!/bin/csh -f

if ($#argv != 2) then
  echo "Usage: gen_modifier <type> <name>"
  exit 1
endif

set type = $1
set name = $2

set basic = 0

if ($type == "bool" || $type == "int" || $type == "double") then
  set basic = 1
endif

set name1 = `echo $name | sed "s/\(.*\)_/\1/"`
set name2 = `echo $name1 | sed "s/\([a-z]\)/\U\1/"`

set var = "${name1}_"

set setter = "set${name2}"
set getter = "${name1}"

set tmpVar = "v";

if ($basic == 1) then
  if ($type == "bool") then
    set getter = "is${name2}"
    set tmpVar = "b";
  else if ($type == "int") then
    set tmpVar = "i";
  else if ($type == "double") then
    set tmpVar = "r";
  endif

  echo "  ${type} ${getter}() const { return ${var}; }"
  echo "  void ${setter}(${type} ${tmpVar}) { ${var} = ${tmpVar}; }"
else
  echo "  const ${type} &${getter}() const { return ${var}; }"
  echo "  void ${setter}(const ${type} &${tmpVar}) { ${var} = ${tmpVar}; }"
endif

exit 0

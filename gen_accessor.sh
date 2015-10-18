#!/bin/csh -f

set type = ''
set name = ''
set ptr  = 0
set qt   = 0
set dcl  = 0
set snps = 0
set args = ()

while ($#argv > 0)
  if      ("$1" == "-p") then
    set ptr = 1
    shift
  else if ("$1" == "-qt") then
    set qt = 1
    shift
  else if ("$1" == "-dcl") then
    set dcl = 1
    shift
  else if ("$1" == "-snps") then
    set snps = 1
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

if ("$type" != "" && "$name" == "") then
  set name = $type
  set type = "int"
endif

if ("$name" == "" || "$type" == "") then
  echo "Usage: gen_accessor.sh [-p] <type> <name>"
  exit 1
endif

set basic = 0

if ("$type" == "bool" || "$type" == "int" || "$type" == "double") then
  set basic = 1
endif

set init = "{ }"

if      ("$type" == "bool") then
  set init = "{ false }"
else if ("$type" == "int") then
  set init = "{ 0 }"
else if ("$type" == "double") then
  set init = "{ 0.0 }"
endif

set name1 = `echo $name | sed "s/\(.*\)_/\1/"`
set name2 = `echo $name1 | sed "s/\([a-z]\)/\U\1/"`

if ($snps == 1) then
  set var = "_${name1}"
else
  set var = "${name1}_"
endif

set setter = "set${name2}"
set getter = "${name1}"

if ($ptr == 0) then
  set tmpVar = "v";
else
  set tmpVar = "p";
endif

if ($qt == 1) then
  echo "  Q_PROPERTY($type READ $getter WRITE $setter)"
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

if ($dcl == 1) then
  echo "  $type $var $init;"
endif

exit 0

#define printqstring
#    printqstringdata $arg0.d
#end
#document printqstring
#  Prints the contents of a Qt QString
#end
#define printqstringdata
#    set $i=0
#    set $d = $arg0
#    while $i < $d->size
#        printf "%c", (char)($d->data[$i++] & 0xff)
#    end
#    printf "\n"
#end
#document printqstringdata
#  Prints the contents of a Qt QString::Data
#  This is useful when the output of another command (e.g. printqmap)
#  shows {d = 0xdeadbeef} for a QString, i.e. the qstringdata address
#  instead of the QString object itself.
#  printqstring $s and printqstringdata $s.d are equivalent.
#end

#define printqstring
#    printqstringdata $arg0.d
#end
#document printqstring
#  Prints the contents of a QString
#end
#define printqstringdata
#    set $i=0
#    set $d = (QStringData *)$arg0
#    while $i < $d->len
#        printf "%c", (char)($d->unicode[$i++].ucs & 0xff)
#    end
#    printf "\n"
#end
#document printqstringdata
#  Prints the contents of a QStringData
#  This is useful when the output of another command (e.g. printqmap)
#  shows {d = 0xdeadbeef} for a QString, i.e. the qstringdata address
#  instead of the QString object itself.
#  printqstring $s and printqstringdata $s.d are equivalent.
#end

define printqstring
  set $d=$arg0.d
  printf "(Qt5 QString)0x%x length=%i: \"",&$arg0,$d->size
  set $i=0
  set $ca=(const ushort*)(((const char*)$d)+$d->offset)
  while $i < $d->size
    set $c=$ca[$i++]
    if $c < 32 || $c > 127
      printf "\\u%04x", $c
    else
      printf "%c" , (char)$c
    end
  end
  printf "\"\n"
end

define printqstringd
  set $d=$arg0
  printf "(Qt5 QString) length=%i: \"",$d->size
  set $i=0
  set $ca=(const ushort*)(((const char*)$d)+$d->offset)
  while $i < $d->size
    set $c=$ca[$i++]
    if $c < 32 || $c > 127
      printf "\\u%04x", $c
    else
      printf "%c" , (char)$c
    end
  end
  printf "\"\n"
end

define printqstring1
  set $d=(QStringData*)$arg0.d
  printf "(Qt5 QString)0x%x length=%i: \"",&$arg0,$d->size
  set $i=0
  while $i < $d->size
    set $c=$d->data()[$i++]
    if $c < 32 || $c > 127
      printf "\\u%04x", $c
    else
      printf "%c" , (char)$c
    end
  end
  printf "\"\n"
end

define printqfont
    print *($arg0).d
    printqstring ($arg0).d->request.family
    print ($arg0).d->request.pointSize
end
document printqfont
  Prints the main attributes from a QFont, in particular the requested
  family and point size
end

define printqcolor
    printf "(%d,%d,%d)\n", ($arg0).red(), ($arg0).green(), ($arg0).blue()
end
document printqcolor
  Prints a QColor as (R,G,B).
  Usage: 'printqcolor <QColor col>
end

define printqstringlist
    set $list = $arg0
    set $len = $list.sh->nodes
    output $len
    printf " items in the list\n"
    set $it = $list.sh->node->next
    set $end = $list.sh->node
    while $it != $end
        printqstring $it->data
        set $it = $it->next
    end
end
document printqstringlist
  Prints the contents of a QStringList.
  Usage: printqstringlist mylist
end

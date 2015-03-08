alias s 'unsetenv LOGIN_RUN; source ~/.cshrc'

#setenv MORE_CMD 'more -f'
#setenv MORE_CMD 'less -R'
setenv MORE_CMD 'CMore'

new_which -s Cls

if ($status == 0) then
  alias ls  'Cls -C --color --special "*.o" --special6 core \!* | $MORE_CMD'
  alias ll  'Cls -Alg --color --special "*.o" --special6 core \!* | $MORE_CMD'
  alias lll 'Cls -Alg --links --color --special "*.o" --special6 core \!* | $MORE_CMD'
  alias LL  'Cls -AlgR --color --special "*.o" --special6 core \!* | $MORE_CMD'
  alias LLL 'Cls -AlgR --links --color --special "*.o" --special6 core \!* | $MORE_CMD'
  alias l2  'Cls -C --color --special "*.o" --special6 core --width 39 \!* | $MORE_CMD'
  alias l3  'Cls -C --color --special "*.o" --special6 core --width 25 \!* | $MORE_CMD'
  alias l4  'Cls -C --color --special "*.o" --special6 core --width 19 \!* | $MORE_CMD'
  alias l5  'Cls -C --color --special "*.o" --special6 core --width 15 \!* | $MORE_CMD'
  alias l6  'Cls -C --color --special "*.o" --special6 core --width 12 \!* | $MORE_CMD'
  alias l7  'Cls -C --color --special "*.o" --special6 core --width 10 \!* | $MORE_CMD'
  alias l8  'Cls -C --color --special "*.o" --special6 core --width 9 \!* | $MORE_CMD'
  alias l9  'Cls -C --color --special "*.o" --special6 core --width 8 \!* | $MORE_CMD'
  alias l10 'Cls -C --color --special "*.o" --special6 core --width 7 \!* | $MORE_CMD'
  alias l.  'Cls -C --color --special "*.o" --special6 core -d .??* \!*'

  alias LE  'Cls -AlgR --color --special "*.o" --special6 core --include X'
  alias LLX 'Cls -AlgR --color --include x --exclude d --exclude B --exclude l \!* | $MORE_CMD'

  alias ls_bad 'Cls -C --color --special "*.o" --special6 core \!* --include B | $MORE_CMD'
  alias ls_no_sl 'Cls -C --color --special "*.o" --special6 core \!* --exclude l | $MORE_CMD'
else
  alias ls  'ls -C \!* | $MORE_CMD'
  alias ll  'ls -Alg \!* | $MORE_CMD'
  alias lll 'ls -Alg \!* | $MORE_CMD'
  alias LL  'ls -AlgR \!* | $MORE_CMD'
  alias LLL 'ls -AlgR \!* | $MORE_CMD'
  alias l2  'ls -C \!* | $MORE_CMD'
  alias l3  'ls -C \!* | $MORE_CMD'
  alias l4  'ls -C \!* | $MORE_CMD'
  alias l5  'ls -C \!* | $MORE_CMD'
  alias l6  'ls -C \!* | $MORE_CMD'
  alias l7  'ls -C \!* | $MORE_CMD'
  alias l8  'ls -C \!* | $MORE_CMD'
  alias l9  'ls -C \!* | $MORE_CMD'
  alias l10 'ls -C \!* | $MORE_CMD'
  alias l.  'ls -C -d .??* \!* | $MORE_CMD'
  alias LE  'ls -AlgR'
endif

alias hh history

unalias l
unalias la

alias ff 'find . -name "\!*" -print'
alias ffd 'find \!^ -name "\!$" -print'

alias fcmd 'find . -name "\!:1" -print0 | xargs -0 \!:2-$'

alias fvi 'vi `find . -name "\!*" -print`'
alias frm 'new_rm `find . -name "\!*" -print`'

alias Gvi 'vi `grep -l \!*`'
alias Gtouch 'touch `grep -l \!*`'

alias vi_which 'vi `new_which \!*`'

alias rgrep 'rgrep.csh \!:1 "\!:2-$"'
alias rword_match 'rword_match.csh \!:1 "\!:2-$"'

alias dbx gdb

alias ~ 'cd ~\!*'
alias . 'cd $cwd'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'

alias cddata  'cd ../../data/$cwd:t/\!*'
alias cddoc   'cd ../../doc/$cwd:t/\!*'
alias cdinc   'cd ../../include/$cwd:t/\!*'
alias cdsrc   'cd ../../src/$cwd:t/\!*'
alias cdtest  'cd ../../test/$cwd:t/\!*'
alias cdunit  'cd ../../unit/$cwd:t/\!*'
alias cdobj   'cd $OBJ_DIR'
alias cdlib   'cd $LIB_DIR'
alias cdbin   'cd $BIN_DIR'
alias cdprogs 'cd $PROGS_DIR'

alias cdlocal 'cd /work/colinw/\!*'

alias cdtmp 'cd /work/colinw/\!*'

alias cddir 'cddir.csh $cdpath \!*'

alias touch /bin/touch -c

alias relink 'touch *.o; make'

alias check_cwd 'if ("$cwd" != `\pwd`) set cwd_pwd = "#link#"; if ("$cwd" == `\pwd`) set cwd_pwd = ""'

alias shell_cwd 'CTermAPC -dir $cwd'

alias set_prompt 'set prompt="%B`echo $cwd | CDirFmt -nosplit`%b> "'
alias set_prompt1 'set prompt="%B/>%b "'

if (! $?term) then
  set term = xterm
endif

if ($term == xterm) then
  if ($?CTERM_VERSION) then
#   alias cd 'cd \!*;set_window_title $cwd;check_cwd;set_prompt'
#   alias cd 'cd \!*;set_window_title $cwd;shell_cwd;set_prompt'
    alias cd 'cd \!*;set_window_title $cwd;check_cwd;shell_cwd;set_prompt'
  else
    alias cd 'cd \!*;set_window_title $cwd;check_cwd;set_prompt'
  endif
# alias cd 'cd \!*;set_window_title $cwd;set_prompt1'
else
  alias cd 'cd \!*;set_prompt1'
endif

alias Xinit 'startx >& /dev/null'

alias man_page 'nroff -man \!* | $MORE_CMD'

alias cdup 'cd $cwd:h'
alias cdpwd 'cd `\pwd`'

alias cdcopy 'echo "cd `\pwd`" >&! ~/.cdcopy'
alias cdpaste 'source ~/.cdcopy'

alias cdexec 'cdexec.sh \!* >! /tmp/cdexec.sh; source /tmp/cdexec.sh'

alias rm new_rm
alias mv new_mv
alias cp new_cp

#alias vi   '/bin/vim \!*; cd .'
#alias view '/bin/vim -v \!*; cd .'

alias clean_path 'clean_path.csh > /usr/tmp/set_path.$$.csh; source /usr/tmp/set_path.$$.csh; \rm /usr/tmp/set_path.$$.csh'

alias rcd 'cd `rcd.csh \!*`'

alias ci 'echo Command not found'

alias path 'echo $path'

alias pathadd 'set path = (\!* $path)'
alias pathaddend 'set path = ($path \!*)'

alias envadd 'echo \!:1 "$\:1^\!:2\!:3-$"'

alias resetpath 'set path = ($stdpath)'

alias inpath 'check_in_path \!* $path'

alias ld_library_path_add '(if ($?LD_LIBRARY_PATH) setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:\!* ; if (! $?LD_LIBRARY_PATH) setenv LD_LIBRARY_PATH \!*)'

alias ld_library_path_add 'eval `add_env.sh LD_LIBRARY_PATH \!* :`'

alias rename 'rename.csh "\!:1" "\!:2" "\!:3"'

#alias make 'make -j 4'

#-----

alias resize_80_60 'echo -n "[8;60;80t"'
alias resize_100_60 'echo -n "[8;60;100t"'

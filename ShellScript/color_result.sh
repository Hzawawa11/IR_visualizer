#!/bin/zsh

while read line; do
  printf '\e[33m'$line'\e[m\n'
  printf '\e[36m'${line#*:}'\e[m\n'

done

#!/bin/bash
# echo '
# 256色
# 前: 38;05;色番号
# 背: 48;05;色番号
# '
# for i in {0..255} ; do
#   printf "\x1b[38;05;${i}m 38;05;${i} "
# done
# echo ''
# for i in {0..255} ; do
#   printf "\x1b[48;05;${i}m 48;05;${i} "
# done
# echo ''
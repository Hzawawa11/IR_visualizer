#!/bin/zsh
echo ""
while read line; do
  echo $line | awk '{printf ("\x1b[48;05;%dm ", $1)}'
  echo $line | awk '{printf ("\033[30m %3d \033[0m %35s \033[34m %-s \033[0m\n", $1, $2, $3)}'
done

# 256色
# 前: 38;05;色番号
# 背: 48;05;色番号
# '
# for i in {0..255} ; do
  # printf "\x1b[38;05;${i}m 38;05;${i} "
# done
# echo ''
# for i in {0..255} ; do
  # printf "\x1b[48;05;${i}m 48;05;${i} "
# done
# echo ''
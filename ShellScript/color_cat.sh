echo ""
while read line; do
  # echo $line | awk '{printf ("\x1b[48;05;%dm ", $1)}'
  echo $line | awk '{printf ("\033[30m %3d \033[0m %35s \033[34m %-s \033[0m\n", $1, $2, $3)}'
  # echo $line
done
#!/bin/zsh
# script_dir=$(cd $(dirname ${BASH_SOURCE:-$0})/..;pwd) #http://qiita.com/yudoufu/items/48cb6fb71e5b498b2532
echo "Execution... main.rb"
# echo $script_dir
if ["cat" = $1]; then
  detection="${script_dir}/ShellScript/color_cat.sh"
  echo $detection
else
  detection="${script_dir}/ShellScript/color_result.sh"
fi
execute="ruby ${script_dir}/main.rb"

ruby /Users/hiro/Program/Ruby/IR_Reader/main.rb | /Users/hiro/Program/Ruby/IR_Reader/ShellScript/color_result.sh
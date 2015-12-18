# 配列の内容を表示 print_r(array);
def print_r(*array)
  array.each do |element| 
    puts element
  end
end

def var_p(var, split)
  print sprintf("%15s #{split}", var)
end
result_file = "/Users/hiro/Program/Ruby/IR_Reader/result/result.txt"

class Visualize
  def initialize(result:"#{result_file}", file:nil ,num:1)
    @result = result
    @file = file
    @num = num
  end

  def visualize()
    flag = 0
    buf = ""

    # 指定行数取得
    visualize_line = ""
    result = open(@result, "r")
    result.each_line do |line|
      if @num == result.lineno
        visualize_line = line
        break
      end
    end
    result.close()

    # 色をぬる行数
    arr = Array.new
    # スペースで区切って 3番目の値を/\D|\n/で分割して，なければ追加する
    lineNumArr = visualize_line.split(/\D|\n/) 
    lineNumArr.size.times do |i|
       arr << lineNumArr[i].to_i  if lineNumArr[i] != '' && i != 0 #数字 かつ 行頭の個数を取り除く
    end 

    read_file = open(@file, "r")
    color = nil
    before_color = nil
    read_file.each_line do |line|
      color = 33  if(arr.uniq.include?(read_file.lineno))
      # if color == nil && before_color == 33
        # puts ""
      # end
      # if color != nil
        system("printf '\033[#{color}m'")
        print "#{read_file.lineno} #{line}" 
        system('printf "\033[0m"')
      # end
      before_color = color
      color = nil
    end

    read_file.close()

  end #end function 
end # end class
DIR = File.expand_path(File.dirname(__FILE__)) unless defined? DIR
require DIR + '/dbgScaner'
require DIR + '/grid'

class List
  attr_reader :function, :label, :opecode, :line #インスタンス変数の参照や更新
  def initialize(function:"main", label:"", opecode:"", line:1)
    @function = function   # 所属関数
    @label = label      # 所属ラベル
    @opecode = opecode    # 命令名
    @line = line       # 行番号
  end

  def display
    p "#{@function}, #{@label}, #{@opecode}, #{@line}"
  end

end # end class
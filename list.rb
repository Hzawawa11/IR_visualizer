DIR = File.expand_path(File.dirname(__FILE__)) unless defined? DIR
# require 'RelativeDbg'
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

  def grouping
    # include 'grid'
    # grid = Grid.new()
    ## BasicBlockの中のInstructionを3つに束ねグループ化
    # grid.InstrGroup(@function, @label, @line)
    ## BasicBlockごとに分割
    # grid.BasicGroup(this, thisLabel, thisLine)
    ## functionごとに分割
    # grid.FunctionGroup(this, thisFunction)
    return ret
  end #

end # end class
=begin
# リスト構造
class List
  def initialize
    @Function = nil   # 所属関数
    @Label = nil      # 所属ラベル
    @Opecode = nil    # 命令名
    @Line = nil       # 行番号
    @NextLabel = nil  # 次のラベル
  end

  attr_accessor :Function, :Label, :Opecode, :Line, :NextLabel #インスタンス変数の参照や更新


  def add_last(function, label, opecode, line)
    this = self
    this = this.NextLabel until this.NextLabel.nil?
    this.NextLabel = List.new
    this.NextLabel.Function = function
    this.NextLabel.Label    = label  
    this.NextLabel.Opecode  = opecode 
    this.NextLabel.Line     = line
  end

  def size
    this = self
    i = 0
    i += 1 while this = this.NextLabel
    return i
  end

  def each
    this = self.NextLabel
    self.size.times do
      yield "#{this.Line}: "
      yield "#{this.Function}: "
      yield "#{this.Label}: "
      yield "#{this.Opecode}\n"
      this = this.NextLabel
    end
  end

  def cat(nextlabel = self.NextLabel) 
    this = nextlabel
    thisFunction = this.Function
    thisLabel = this.Label
    thisLine = this.Line
    join = ''
    ret = this.NextLabel

    grid = Grid.new
    ## BasicBlockの中のInstructionを3つに束ねグループ化
    grid.InstrGroup(this, thisFunction, thisLabel, thisLine)

    ## BasicBlockごとに分割
    # grid.BasicGroup(this, thisLabel, thisLine)

    ## functionごとに分割
    # grid.FunctionGroup(this, thisFunction)
    return ret
  end 

end #class List
=end
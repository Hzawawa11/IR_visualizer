#!/usr/bin/ruby
DIR = File.expand_path(File.dirname(__FILE__)) unless defined? DIR
require DIR + '/relativeC'
require DIR + '/dbgScaner'
require DIR + '/read'
require DIR + '/grid'
require DIR + '/summarize'
require DIR + '/visualize'

# require 'optparse'  #command を取得するために使用する
# p DIR

# opt = OptionParser.new
# opt.version = '0.0.1'
# opt.on('-w  from write', '--write') {|v| OPTS[:o] = v}
# opt.on('-r from read', '--read') {|v| OPTS[:o] = v}
# opt.on('-o from ouput', '--output') {|v| OPTS[:o] = v}
# opt.parse!(ARGV)
# p ARGV[0]
# p OPTS

flag = 0
output_num = 1;
# -- mainflow -------------
if ARGV.size < 1
  STDERR.print "Usage: \"ruby main.rb [option]\" \n"
  exit
end

if ARGV[0] == "-w" 
  relative = RelativeC.new(read: $FileName+".ll", write:"#{DIR}/result/line.txt", line:`grep '' #{$FileName}.c | wc -l`.to_i)
  relative.create
  dbg = RelativeDbg.new(read: $FileName+".ll", write:"#{DIR}/result/gdb.txt")
  dbg.create
  flag = 1
end

if ARGV[0] == "-r" || flag == 1
  grid = Grid.new(write:"#{DIR}/result/instr.txt", list: Read.store, size: Read.size)
  
  unless ARGV[1] && ARGV[2]
    print "どの組み合わせで行いますか．(From 'min' to 'max')\n"
    print "min ->"; min = STDIN.gets.chomp.to_i
    print "max ->"; max = STDIN.gets.chomp.to_i
  else 
    min = ARGV[1].to_i
    max = ARGV[2].to_i
  end

  grid.InstrGroup(max:max, min:min)
  # grid.BlockGroup
  # grid.FunctionGroup

  # result = Result.new(option:2) ## llvm = 0, meta = 1, C = 2
  # result.list       #.llと命令のリストの作成
  # counter = result.output #      ;        の表示

  flag = 1
end

if ARGV[0] == "-v" || flag == 1
  # if flag == 1
    result = Result.new(option:2) ## llvm = 0, meta = 1, C = 2
    result.list       #.llと命令のリストの作成
    counter = result.output #      ;        の表示
  # end
  p "何番目を表示しますか？"
  print "->"; output_num = STDIN.gets.chomp.to_i
  exit if output_num > counter
  
  result.output(num:output_num)

  p "'決定キー'で出力します. ->"
  unless STDIN.gets == "\n"
    print "error:\n"
    exit
  end

  RESULT = "/Users/hiro/Program/Ruby/IR_Reader/result/result.txt"
  visualize = Visualize.new(result:RESULT, file: $FileName+".c", num:output_num)
  visualize.visualize
end

# -------------------------

DIR = File.expand_path(File.dirname(__FILE__)) unless defined? DIR
require DIR + '/relativeC'
require DIR + '/dbgScaner'
require DIR + '/read'
require DIR + '/grid'
require DIR + '/summarize'
p DIR
# -- mainflow -------------
relative = RelativeC.new(read: $FileName+".ll", write:"./result/line.txt", line:`grep '' #{$FileName}.c | wc -l`.to_i)
relative.create

dbg = RelativeDbg.new(read: $FileName+".ll", write:"./result/gdb.txt")
dbg.create

grid = Grid.new(list: Read.store, size: Read.size)

grid.InstrGroup
# grid.BlockGroup
# grid.FunctionGroup

result = Result.new(option:0) ## llvm = 0, meta = 1, C = 2
result.list
result.output
# -------------------------
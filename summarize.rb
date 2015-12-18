DIR = File.expand_path(File.dirname(__FILE__)) unless defined? DIR
require DIR + '/relativeC'
require DIR + '/dbgScaner'
require DIR + '/read'
require DIR + '/grid'

# -- mainflow -------------
# relative = RelativeC.new(read: $FileName+".ll", write:"./result/line.txt", line:`grep '' #{$FileName}.c | wc -l`.to_i)
# relative.create

# dbg = RelativeDbg.new(read: $FileName+".ll", write:"./result/gdb.txt")
# dbg.create

# grid = Grid.new(list: Read.store, size: Read.size)

# grid.InstrGroup
# # grid.BlockGroup
# # grid.FunctionGroup

class Result 

  @@instr_list = Hash.new
  @@line_list = Hash.new

  def initialize (write: "#{DIR}/result/result.txt", gdb:"#{DIR}/result/gdb.txt", instr:"#{DIR}/result/instr.txt", option:0)
    @result_file = write
    @gdb_file = gdb
    @option = option
    @instr_file = instr
  end

  def relative(llvmLine:"")
    File.open(@gdb_file, "r").each_line do |gdb_line|
      token = gdb_line.split(/[ ,(\n)]/)
      return token[@option] if token[0] == llvmLine
    end
    return ""
  end

  def list
    File.open(@instr_file, "r").each_line do |instr_line|
      token = instr_line.split(/[ ,(\n)]/)
      if @@instr_list.has_key?(token[0])
        @@instr_list[token[0]] += 1
        @@line_list[token[0]] = @@line_list[token[0]] + "," + relative(llvmLine:token[1])
        next
      end
      @@instr_list[token[0]] = 1
      @@line_list[token[0]] = relative(llvmLine:token[1])               # llvm
    end # open file 
  end

  def output
    for var in @@instr_list.sort{|(k1, v1), (k2, v2)| v2 <=> v1 } do
      print "#{var}:#{@@line_list[var[0]]} \n"
    end
  end

end

# instr_list = {}
# line_list = {}

=begin
File.open("./result/instr.txt", "r").each_line do |instr_line|
  token = instr_line.split(/[ ,(\n)]/)

  if instr_list.has_key?(token[0])
    instr_list[token[0]] += 1
    line_list[token[0]] = line_list[token[0]] + "," + result.relative(option:0 ,llvmLine:token[1])
    next
  end
  instr_list[token[0]] = 1
  line_list[token[0]] = result.relative(option:0 ,llvmLine:token[1])               # llvm
end 
=end
# for var in instr_list.sort{|(k1, v1), (k2, v2)| v2 <=> v1 } do
#   print "#{var} #{line_list[var[0]]} \n"
# end


=begin
instr_file = open("./result/instr.txt", "r")

def relativeMeta(num)
  buf = ""
  gdb_file = open("./result/gdb.txt", "r")
  gdb_file.each_line do |gdb_line|
    token = gdb_line.split(/[ ,(\n)]/)
    if token[0] == num
      buf = token[1]
    end
  end
  gdb_file.close()
  return buf
end

def relativeC(num)
  buf = ""
  gdb_file = open("./result/gdb.txt", "r")
  gdb_file.each_line do |gdb_line|
    token = gdb_line.split(/[ ,(\n)]/)
    if token[0] == num
      buf = token[2]
    end
  end
  gdb_file.close()
  return buf
end


instr_list = {}
line_list = {}

instr_file.each_line do |instr_line|
  token = instr_line.split(/[ ,(\n)]/)
  
  if instr_list.has_key?(token[0])
    instr_list[token[0]] += 1
    line_list[token[0]] = line_list[token[0]] + "," +token[1]               # llvm
    # line_list[token[0]] = line_list[token[0]] + "," +relativeMeta(token[1]) # meta 
    # line_list[token[0]] = line_list[token[0]] + "," +relativeC(token[1])      # C
    next
  end
  instr_list[token[0]] = 1    
  line_list[token[0]] = token[1]                          # llvm
  # line_list[token[0]] = relativeMeta(token[1])            # meta
  # line_list[token[0]] = relativeC(token[1])                 # C
end
instr_file.close()

instr_file = open("./result/instr.txt", "r")
instr_file.each_line do |instr_line|
  token = instr_line.split(/[ ,(\n)]/)
  token[0]
end 
instr_file.close()

for var in instr_list.sort{|(k1, v1), (k2, v2)| v2 <=> v1 } do
  print "#{var} #{line_list[var[0]]} \n"
end
=end
 

=begin
for var in line_list do
  print "line = #{var} \n"
end
=end
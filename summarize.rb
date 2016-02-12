DIR = File.expand_path(File.dirname(__FILE__)) unless defined? DIR
require DIR + '/relativeC'
require DIR + '/dbgScaner'
require DIR + '/read'
require DIR + '/grid'

class Result 

  @@instr_list = Hash.new
  @@line_list = Hash.new

  def initialize (write: "#{DIR}/result/result.txt", gdb:"#{DIR}/result/gdb.txt", instr:"#{DIR}/result/instr.txt", option:0)
    @write = write
    @gdb_file = gdb
    @option = option
    @instr_file = instr
  end

  def relative(llvmLine:"")
    File.open(@gdb_file, "r").each_line do |gdb_line|
      token = gdb_line.split(/[ ,(\n)]/)
      # p "#{token[0]} == #{llvmLine}"
      # p "#{token[0]} = #{llvmLine} => #{token[@option]}" if token[0] == llvmLine
      return token[@option] if token[0] == llvmLine
    end
    return ""
  end

  def list
    File.open(@instr_file, "r").each_line do |instr_line|
      token = instr_line.split(/[ ,(\n)]/)

      rel = ""
      for i in token[1].split(/[|]/) do
        # print "#{i} " unless i == ""
        rel = rel+ ","+ relative(llvmLine:i) unless i == ""
        # p rel unless i == ""
      end      
      # 命令グループが存在するか
      if @@instr_list.has_key?(token[0])
        @@instr_list[token[0]] += 1
        @@line_list[token[0]] = @@line_list[token[0]] + "," + ":"+ rel 
        next
      end
      @@instr_list[token[0]] = 1
      @@line_list[token[0]] = ":" +rel               # llvm

      rel = "" # initialize
    end # open file 
  end

  def output(num:0)
    write_file = open(@write, "w+")
    counter = 1;
    color = nil
    for var in @@instr_list.sort{|(k1, v1), (k2, v2)| v2 <=> v1 } do
      lineNum = @@line_list[var[0]].split(/\D/).uniq
      # p lineNum
      lineNum.delete_at(0)
      color = (num == counter ? 33 : nil);
      if(var[1] > 1)
        system("printf '\033[#{color}m'")
        print "(#{counter}) #{var[1]} #{var[0]}\n" 
        system('printf "\033[0m"')      
        
        write_file.print "#{var[1]} #{var[0]} #{lineNum} \n" if num != 0
        
        counter += 1
      end
    end
    write_file.close()
    return counter -1
  end

end #close class
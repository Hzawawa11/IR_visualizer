DIR = File.expand_path(File.dirname(__FILE__)) unless defined? DIR
require DIR + '/read'
require DIR + '/grouping'
require DIR + '/Relative'

class Result 

  @@instr_list = Hash.new
  @@line_list = Hash.new

  def initialize (write: "#{DIR}/result/result.txt", instr:"#{DIR}/result/instr.txt", option:0)
    @write = write
    @option = option
    @instr_file = instr
  end

  def list
    relative = Relative.new()
    File.open(@instr_file, "r").each_line do |instr_line|
      token = instr_line.split(/[ ,(\n)]/)

      rel = ""
      for val in token[1].split(/[|]/) do
        rel = rel+ ","+ relative.relative(llvmLine:val).to_s unless val == ""
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

  def output(num:1)
    write_file = open(@write, "w+")
    counter = 1
    color = nil
    for var in @@instr_list.sort{|(k1, v1), (k2, v2)| v2 <=> v1 } do
      lineNum = @@line_list[var[0]].split(/\D/).uniq
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

  def output2(memFlag:false)
    write_file = open(@write, "w+") if memFlag == true
    counter = 1
    color = nil
    color_base = 37;

    for var in @@instr_list.sort{|(k1, v1), (k2, v2)| v2 <=> v1 } do
      lineNum = @@line_list[var[0]].split(/\D/).uniq
      lineNum.delete_at(0)
      color = (color_base  >= 30? color_base : nil);
      if(var[1].to_i > 1)
        system("printf '\033[#{color}m'")
        print "(#{counter}) #{var[1]} #{var[0]}\n" 
        system('printf "\033[0m"')      
        
        write_file.print "#{var[1]} #{var[0]} #{lineNum} \n" if memFlag == true
        
        counter += 1
      end
      color_base -= 1
    end
    write_file.close() if memFlag == true
    return counter -1
  end

end #close class
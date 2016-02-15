# result
# 25,!18,30 | llvm行, メタ変数, C行
DIR = File.expand_path(File.dirname(__FILE__)) unless defined? DIR

class Relative

  @@dbg_llvm = Hash.new()
  @@dbg_c = Hash.new()


  attr_reader :read #read only
  def initialize(read:"", cline:0)
    @read = read 
    @line = cline # 
  end

  def dbg_llvmline
    read_file = open(@read, "r")

    read_file.each_line do |line| #1行単位で読み込み
      if line.include?("dbg")
        token = line.split(/[ ,(\n)]/)
        @@dbg_llvm[token[token.size-1]] = read_file.lineno
      end
    end #each_line
    read_file.close()
    return @@dbg_llvm
  end #end dbg_llvmline

  def dbg_Cline

    read_file = open(@read, "r")
    read_file.each_line do |line| #1行単位で読み込み
      next unless line =~ /\A!\d+/

      token = line.split(/[\ ,]/)
      next if token[3].nil?

      if integer_string?(str:token[3]) && token[3].to_i <= @line  #token[3]がCソースに対応してる場合
        @@dbg_c[token[0]] = token[3]
      end

    end # end each other line
    read_file.close()
    return @@dbg_c
  end # end create

  def relative(llvmLine:"")
    @@dbg_c[@@dbg_llvm.invert[llvmLine.to_i]]
  end


  def integer_string?(str:"")
    begin
      Integer(str)
      true
    rescue ArgumentError
      false
    end
  end #end integer_string

end #end Relative class

# -- Example -------------- 
=begin
$FileName = "/Users/hiro/Program/C/Sample/Sample10/cg"
relative = Relative.new(read: $FileName+".ll", cline: `grep '' #{$FileName}.c | wc -l`.to_i )
relative.dbg_Cline()
relative.dbg_llvmline()

p relative.relative(llvmLine:"106")

=end

# p ""+nil.to_s
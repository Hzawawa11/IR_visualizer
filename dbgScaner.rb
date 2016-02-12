# result
# 25,!18,30 | llvm行, メタ変数, C行
DIR = File.expand_path(File.dirname(__FILE__)) unless defined? DIR

class RelativeDbg
  def initialize(read:"", write:"#{DIR}/result/gdb.txt")
    @write = write
    @read = read
  end

  def create
    write_file = open(@write, "w+")
    read_file = open(@read, "r")

    read_file.each_line do |line| #1行単位で読み込み
      flag = 0
      token = line.split(/[ ,(\n)]/)
      token.each_with_index do |t, i|
        if t =~ /!dbg/
         flag = 1 ; next
        end
        
        if flag == 1
          read_gen = open("#{DIR}/result/line.txt", "r")
          read_gen.each_line do |line|
            token = line.split(/[,(\n)]/)
            token.each {|t1| write_file.print "#{read_file.lineno},#{line.chomp}\n" if t == t1}
          end # end for

          read_gen.close()
          flag = 0
        end # end if

      end #end token
    end # end each other line

    read_file.close()
    write_file.close()
  end

  def remove
    `rm #{@write}`
  end
end
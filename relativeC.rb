DIR = File.expand_path(File.dirname(__FILE__)) unless defined? DIR

class RelativeC 
  attr_reader :read, :write #read only
  def initialize(read:"", write:"#{DIR}/result/line.txt", line:1)
    @write = write
    @read = read
    @line = line
  end
=begin
  def open(file:"", option:"") 
    discriptor = open(file, option)
  end
  def close 
  end
=end
  def create
    write_file = open(@write, "w+")
    read_file = open(@read, "r")

    read_file.each_line do |line| #1行単位で読み込み
      next unless line =~ /\A!/

      token = line.split(/[ ,]/)
      buf = ""
      token.each_with_index do |t, i|
        if i == 0 && t =~ /\A![0-9]/
          buf = t ; next
        end
        if i == 4 && t.to_i <= @line && buf != ""
          # print "to : #{t.to_i} : #{buf}\n";
          write_file.print "#{buf},#{t.to_i}\n";
          buf = nil
        end
      end #end token
    end # end each other line

    read_file.close()
    write_file.close()
  end # end create

  def remove
    `rm #{@write}`
  end
end

# Example
=begin
load("loadFile.rb")
relative = RelativeC.new(read: $FileName+".ll", write:"./result/line.txt", line:`grep '' #{$FileName}.c | wc -l`.to_i)
relative.create
# relative.remove
=end 

=begin
llvm, C
!1,0
!2,0
!3,0
!7,2
!8,2
!9,0
!10,4
!11,6
!13,7
!15,8
!16,8
!18,9
!20,10
!21,11
!23,13
=end
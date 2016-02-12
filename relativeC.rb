DIR = File.expand_path(File.dirname(__FILE__)) unless defined? DIR
class RelativeC 
  attr_reader :read, :write #read only
  def initialize(read:"", write:"#{DIR}/result/line.txt", line:1)
    @write = write
    @read = read
    @line = line
  end

  def create 
    write_file = open(@write, "w+")
    read_file = open(@read, "r")

    read_file.each_line do |line| #1行単位で読み込み
      next unless line =~ /\A!/

      token = line.split(nil)
      buf = ""
      token.each_with_index do |t, i|
        if i == 0 && t =~ /\A![0-9]/
          buf = t ; next
        end
        if i == 3 && t.to_i <= @line && buf != ""
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
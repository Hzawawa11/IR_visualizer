DIR = File.expand_path(File.dirname(__FILE__)) unless defined? DIR

class Grid
  def initialize(write:"#{DIR}/result/instr.txt", list:nil, size:0)
    @list = list
    @size = size
    @write = write
  end

  def InstrGroup
    count = 0
    buf = ""
    write_file = open(@write, "w+")

    @size.times do |index|
      baseFunction = @list[index].function
      baseLabel = @list[index].label
      for i in 0..2 do
        break if @list[index+i] == nil
        if baseFunction == @list[index+i].function && baseLabel == @list[index+i].label
          buf = buf + @list[index+i].opecode
          count += 1
        end # end if
      end # end for
      
      write_file.puts "#{buf},#{@list[index].line}"  if count == 3

      buf = ""
      count = 0
    end # end @size.times
    write_file.close()
  end # end method

  def BlockGroup
    buf = ""
    baseLabel = ""
    baseLine = ""
    write_file = open(@write, "w+")
    (@size+1).times do |index|
      break if @list[index] == nil
      if baseLabel == @list[index].label then
        # print @list[index].opecode
        buf = buf + @list[index].opecode
      else 
        write_file.print "#{buf},#{baseLine}\n" if baseLine != nil && buf != ""
        buf = ""
        baseLabel = @list[index].label
        baseLine = @list[index].line
        buf = @list[index].opecode
        # puts @list[index].opecode
      end
    end # end @size.times
    write_file.print "#{buf},#{baseLine}\n"
    write_file.close()
  end # end BasicGroup

  def FunctionGroup
    buf = ""
    baseFunction = ""
    baseLine = ""
    write_file = open(@write, "w+")
    (@size+1).times do |index|
    break if @list[index] == nil
    if baseFunction == @list[index].function then
      # print @list[index].opecode
      buf = buf + @list[index].opecode
    else 
      write_file.print "#{buf},#{baseLine}\n" if baseLine != nil && buf != ""
      buf = ""
      baseFunction = @list[index].function
      baseLine = @list[index].line
      buf = @list[index].opecode
      # puts @list[index].opecode
    end
    end # end @size.times
    write_file.print "#{buf},#{baseLine}\n"
    write_file.close()
  end # end BasicGroup

end

=begin
class Grid
  def InstrGroup(this, thisFunction, thisLabel, thisLine)
    buf = ""
    count = 0
    3.times do |i|
      if this != nil && this.Function == thisFunction && this.Label == thisLabel 
        buf = buf + "#{this.Opecode}"
        this = this.NextLabel
        count += 1
      end
    end
    if count == 3 then
      array[buf] = thisLine
      write_file = open("./result/instr.txt", "a")
      write_file.print "#{buf},#{thisLine}\n"
      write_file.close()
    end
  end # end InstrGroup

  def BasicGroup(this, thisLabel, thisLine)
    buf = ""
      loop{
      if this != nil && this.Label == thisLabel then
        print this.Opecode
        buf = buf + "#{this.Opecode}"
        this = this.NextLabel
      else 
        ret = this
          # if this != nil && this.Opecode == "ret"
            print "\n"; 
          # end 
        break;
      end

      write_file = open("./result/instr.txt", "a")
      write_file.print "#{buf},#{thisLine}\n"
      write_file.close

      # print "\n";

    }
    ret = this
    return ret
  end # end BasicGroup

  def FunctionGroup(this, thisFunction)
    loop{
      if this != nil && this.Function == thisFunction then
        print this.Opecode
        this = this.NextLabel
      else
        ret = this
        print "\n";
        break;
      end 
    }
    return ret
  end # end FuntionGroup
  
end  # end Class
=end

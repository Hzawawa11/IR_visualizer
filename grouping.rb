DIR = File.expand_path(File.dirname(__FILE__)) unless defined? DIR

class Grouping
  def initialize(write:"#{DIR}/result/instr.txt", list:nil, size:0)
    @list = list
    @size = size
    @write = write
  end

# -----------
  def InstrGroup(max:2, min:0)
    size = (max - min) + 1

    count = 0
    buf = ""
    counter_buf = ""
    write_file = open(@write, "w+")

    @size.times do |index|
      baseFunction = @list[index].function
      baseLabel = @list[index].label
      
    for j in min..max do
      for i in 0..j do
        break if @list[index+i] == nil
        if baseFunction == @list[index+i].function && baseLabel == @list[index+i].label
          buf.concat "_#{@list[index+i].opecode}"
          counter_buf.concat "|#{@list[index+i].line.to_s}"
          # buf = buf + "_" + @list[index+i].opecode
          # counter_buf = counter_buf + "|" + @list[index+i].line.to_s
          count += 1
        end # end if
      end # end for
      write_file.puts "#{buf},#{counter_buf}"  if count >= min && count <= max
      
      counter_buf = ""
      buf = ""
      count = 0
    end # min to max
    end # end @size.times
    write_file.close()
  end # end method

# -----------
  def BlockGroup
    buf = ""
    baseLine = ""
    counter_buf = ""
    write_file = open(@write, "w+")
    baseLabel = @list[0].label
    (@size+1).times do |index|
      break if @list[index] == nil
      if baseLabel == @list[index].label then
          buf.concat "_#{@list[index+i].opecode}"
        
        # buf = buf + "_" +@list[index].opecode
        # baseLine = @list[index].line.to_s
          counter_buf.concat "|#{@list[index+i].line.to_s}"

        # counter_buf = counter_buf + "|" + @list[index].line.to_s
      else 
        # p buf
        # p counter_buf
        # write_file.print "#{buf},#{baseLine}\n" if baseLine != nil && buf != ""
        write_file.print "#{buf},#{counter_buf}\n" if baseLine != nil && buf != ""
        buf = ""
        counter_buf = ""
        baseLabel = @list[index].label
        baseLine = @list[index].line
        # buf = @list[index].opecode
      end
    end # end @size.times
    # write_file.print "#{buf},#{baseLine}\n"
    write_file.close()
  end # end BasicGroup


# -----------
  def FunctionGroup
    buf = ""
    baseFunction = ""
    baseLine = ""
    write_file = open(@write, "w+")
    (@size+1).times do |index|
    break if @list[index] == nil
    if baseFunction == @list[index].function then
      buf = buf + @list[index].opecode
    else 
      write_file.print "#{buf},#{baseLine}\n" if baseLine != nil && buf != ""
      buf = ""
      baseFunction = @list[index].function
      baseLine = @list[index].line
      buf = @list[index].opecode
    end
    end # end @size.times
    write_file.print "#{buf},#{baseLine}\n"
    write_file.close()
  end # end BasicGroup

end
# -----------
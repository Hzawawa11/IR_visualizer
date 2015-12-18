GROUP_COUNT = 3
GROUP_COUNT.freeze
DIR = File.expand_path(File.dirname(__FILE__)) unless defined? DIR

require DIR + '/list' ##クラスの中でクラスを呼び出すには？
require DIR + '/loadFile'
require DIR + '/iden'

class Read 
  @@count = 0

  def self.store
    # p $iden
    list = Array.new
    file = open($FileName+".ll", "r:utf-8")
    functionName = ""
    labelName = "1"
    file.each_line do |line|                #1行単位で読み込み
      token = line.split(" ")
      token.each_with_index do |t, i|
        if t == "define"
          # p token[i+2].scan(/\@[a-zA-Z]+[a-zA-Z0-9]*/)
          label = 1
          function = token[i+2].scan(/\@[a-zA-Z_]+[_a-zA-Z0-9]*/)
          functionName = function[0]
          labelName = "1"
        end
        if t =~ /<label>/
          label = t.scan(/[0-9]+/) 
          labelName = label[0]
        end
        # print "#{file.lineno} #{t} = \n #{$iden.include?(t)}"
        if $iden.include?(t)
          list[@@count] = List.new(function:functionName, label:labelName, opecode:t, line:file.lineno)
          # list[@@count].display
          # p list[@@count].label
          @@count += 1
          break
          # p @@count
        end
      end #end token[]
    end # end each other line
    return list
  end

  def self.size 
    @@count-1 
  end
end 

# Example
# list = Read.store

# --------------------------------------
# Main処理
=begin
function = "main"
label = 1
line  = 1
opecode = "define"

token = Array.new
opelist = List.new

file = open($FileName+".ll", "r:utf-8")

file.each_line do |line|                #1行単位で読み込み
  # puts "#{lineage}:#{line}" if line.include?("alloca") 
  token = line.split(" ")
  token.each_with_index do |t, i|
    if t == "define"
      # p token[i+2].scan(/\@[a-zA-Z]+[a-zA-Z0-9]*/)
      label = 1
      function = token[i+2].scan(/\@[a-zA-Z_]+[_a-zA-Z0-9]*/)
      # p function[0]
    end
    label = t.scan(/[0-9]+/) if t =~ /<label>/
    # if t =~ /<label>/
      # label = t.scan(/[0-9]+/)
    # end
    # print "#{file.lineno} #{t}\n" if $iden.include?(t)
    if $iden.include?(t)
      # print "#{function[0]}: #{label[0]}: #{file.lineno} #{t}\n" 
      opelist.add_last(function[0], label[0], t, file.lineno)
    end
  end #end token[] 
end # end each other line


label = opelist.cat 
while label != nil do
  label = opelist.cat(label) 
end 


# 表示
# opelist.each {|i| print i}
=end
# ------------------------------------------------------

=begin
ruby read.rb | sort | uniq -c| sort -r

ruby read.rb | sort | uniq -c| sort
=end
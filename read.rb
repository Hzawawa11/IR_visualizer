DIR = File.expand_path(File.dirname(__FILE__)) unless defined? DIR

require DIR + '/list' ##クラスの中でクラスを呼び出すには？
require DIR + '/loadFile'
require DIR + '/iden'

class Read 
  @@count = 0

  def self.store
    list = Array.new
    file = open($FileName+".ll", "r:utf-8")
    functionName = ""
    labelName = "1"
    file.each_line do |line|                #1行単位で読み込み
      token = line.split(" ")
      token.each_with_index do |t, i|

        if t == "define"
          label = 1
          function = token[i+2].scan(/\@[a-zA-Z_]+[_a-zA-Z0-9]*/)
          functionName = function[0]
          labelName = "1"
        end

        if t =~ /<label>/
          label = t.scan(/[0-9]+/) 
          labelName = label[0]
        end

        if $iden.include?(t)
          list[@@count] = List.new(function:functionName, label:labelName, opecode:t, line:file.lineno)
          @@count += 1
          break
        end
      end #end token[]
    end # end each other line
    return list
  end

  def self.size 
    @@count-1 
  end
end 
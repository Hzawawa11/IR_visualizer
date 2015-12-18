=begin
# 付属ブロックの有無で動作変更
def call_block2()
  if block_given?
    yield
  else
    puts "ブロックが付属されていません"
  end
end
# 実行
call_block2 { puts "ブロック内部" } #=> ブロック内部
call_block2() #=> ブロックが付属されていません
=end

buf = "aa"
scores = {}           # 空のハッシュを作成
scores[buf] = "zz"  # キー"Alice"、値80のペアを追加
p scores[buf]     # キー"Alice"の値を取り出し
                      # 3つのキー＋値からなるハッシュを作成
user = { :name => "k-sato", :email => "k-sato@foo.xx.jp",
         :address => "Tokyo" }
p user[:name]         # キー:nameの値を取り出し

class Foo
    @name
    def name
        @name
    end
    def name=(value)   # 呼び出しは`~.name = "hogs"`でOK
        @name = value
    end
end

obj  = Foo.new()
p obj.name = "zzz"
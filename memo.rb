# CSVを扱うライブラリを読み込む
require "csv"

# クラス定義
class FileOpe

	# 初期設定
	def initialize(dispTodo, errDisp, searchResult)
		@dispTodo = dispTodo
		@fileName  = ""
		@searchResult = searchResult
		@errDisp = errDisp
	end

	# ファイル名入力処理
	def fileName_in
		puts ""
		puts @dispTodo
		puts "拡張子を除いたファイル名を入力してください"
		puts ""
		@fileName  = gets.chop + ".csv"
	end

	# ファイル有無判定新規
	# ファイル作成の場合はファイルが存在する場合でtrue
	# 既存ファイルを開く場合はファイルが存在しない場合でtrue
	def search_file
		return ( File.exist?(@fileName) == @searchResult )
	end

	# エラー処理
	def err_ope
		puts ""
		puts @fileName + @errDisp
	end
end

# 終了処理
def end_ope
	puts ""
	puts "メモを終了します"
	puts ""
end

# インスタンス生成
newFileOpe	= FileOpe.new("ファイルを新規作成します", "はすでに存在します", true)
priFileOpe	= FileOpe.new("既存ファイルを編集します", "が存在しません", false)
fileOpe = [newFileOpe, priFileOpe]
# オブジェクト初期化
selectNum 	= 0
endFlag		= false
searchResult = true

puts "----------------------------------------------------------------------------"
puts "メモを開始"
puts "----------------------------------------------------------------------------"
puts ""

# 1 or 2 or 3が選択されるまで繰り返し選択肢を表示する
loop do
	puts "1：新規でメモを作成する　2：既存のメモを編集する　3：メモを終了する"
	puts ""
	selectNum =  gets.to_i	# 数字を選択する
	if (selectNum == 1 || selectNum == 2 ) then
		break
	elsif selectNum == 3 then
		end_ope()											# メモ終了処理
		endFlag = true										# 終了フラグセット
		break
	else
		puts "1 or 2 or 3で選択してください"
	end
	puts ""
end

# ファイル新規作成
if endFlag then
	# 何もしない
else
	selectNum -= 1
	fileName = fileOpe[selectNum].fileName_in				# ファイル名入力処理
	searchResult = fileOpe[selectNum].search_file			# ファイル有無判定処理
	if searchResult then
		fileOpe[selectNum].err_ope							# エラー処理
		end_ope()											# メモ終了処理
		endFlag = true										# 終了フラグセット
	else
	end
end

if endFlag then
	# 何もしない
else
	puts ""														# 改行
	puts "メモする内容を入力してください"
	puts "メモが完了したらCtrl + Dでメモを保存し終了します" 
	puts ""														# 改行
	memo = STDIN.read											# 文字列読み込み
	CSV.open(fileName,"a") do |csv|								# ファイルオープン
		csv << [memo]											# 文字列書き込み
	end
	puts ""														# 改行
	end_ope()													# メモ終了処理
end

puts "----------------------------------------------------------------------------"
#!/tmp/ruby
require 'date'
require 'optparse'

def display_calendar(year, month)
  # 月の初めの曜日を取得し、カレンダーの最初の行を揃えるための空白を挿入
  first_day_of_month = Date.new(year, month, 1)
  offset = first_day_of_month.wday # 日曜日が0

  # 月と年を表示
  month_year_str = "#{month}月 #{year}"
  puts month_year_str.center(20)
  
  # 曜日を表示 (日本語)
  puts "日 月 火 水 木 金 土"
  
  print "   " * offset

  # 1日から月の最終日までの日付を出力
  (Date.new(year, month, 1)..Date.new(year, month, -1)).each do |date|
    print "\n" if date.sunday?
    if Date.today == date
      print "\e[7m#{date.day.to_s.rjust(2)}\e[0m "
    else
      print "#{date.day.to_s.rjust(2)} "
    end
  end
  puts "\n"
end

def main
  options = { year: Date.today.year, month: Date.today.month }
  
  OptionParser.new do |opt|
    opt.on('-m VAL') {|v| options[:month] = v.to_i }
    opt.on('-y VAL') {|v| options[:year] = v.to_i }
  end.parse!

  display_calendar(options[:year], options[:month])
rescue OptionParser::InvalidOption, OptionParser::MissingArgument
  puts "Usage: ruby script.rb [-m <month>] [-y <year>]"
end

main

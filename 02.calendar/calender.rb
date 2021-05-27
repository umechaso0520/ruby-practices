#!/usr/bin/env ruby
require 'date'
require 'optparse'

#引数yで年、mで月を渡す
options = ARGV.getopts("", "y:#{Date.today.year}", "m:#{Date.today.month}")

#yearとmonth変数それぞれにコマンドで渡した値を格納
year = options["y"].to_i
month = options["m"].to_i

#月初と月末の値を取得し日数を求める
start = Date.new(year,month,1)
finish = Date.new(year,month,-1)
period = (finish - start + 1).to_i

#日付を格納する配列
dates = []

#periodを使って必要な日付を取得しdatesに格納する
period.times do
  dates.push(start)
  start += 1
end

#カレンダー上部表示
month_year = "       #{month.to_s}月 #{year.to_s}    "
day_of_the_week = " 日 月 火 水 木 金 土"
puts month_year
puts day_of_the_week
print "   " * dates[0].wday

#カレンダー表示
dates.each do |date|
  if date.saturday? == false
		if date.day < 10
    	print "  " + date.day.to_s
		else
			print " " + date.day.to_s
		end
	else
		if date.day < 10
    	puts "  " + date.day.to_s
		else
		puts " " + date.day.to_s
		end
	end
end

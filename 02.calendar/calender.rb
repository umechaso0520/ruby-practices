#!/usr/bin/env ruby
require 'date'
require 'optparse'

# 引数yで年、mで月を渡す
options = ARGV.getopts("", "y:#{Date.today.year}", "m:#{Date.today.month}")

# yearとmonth変数それぞれにコマンドで渡した値を格納
year = options["y"].to_i
month = options["m"].to_i

# 月初と月末の値を取得し日数を求める
start = Date.new(year, month, 1)
finish = Date.new(year, month, -1)

# カレンダー上部表示
month_year = "       #{month.to_s}月 #{year.to_s}    "
day_of_the_week = " 日 月 火 水 木 金 土"
puts month_year
puts day_of_the_week
print "   " * start.wday

# カレンダー表示
(start..finish).each do |date|
  print date.day.to_s.rjust(3)
  print "\n" if date.saturday? == true
end

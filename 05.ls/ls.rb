#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'fileutils'

def main
  case ARGV[0]
  when '-a'
    files = Dir.glob(['.*', '*']).sort
    show_files(files)
  when '-l'
    files = Dir.glob(['*']).sort.reverse
    do_loption(files)
  when '-r'
    files = Dir.glob(['*']).sort.reverse
    show_files(files)
  when /[alr][alr][alr]/
    files = Dir.glob(['.*', '*']).sort.reverse
    do_loption(files)
  when nil
    files = Dir.glob(['*']).sort
    show_files(files)
  end
end

def do_loption(files)
  mode_hash = { 7 => 'rwx', 6 => 'rw-', 5 => 'r-x', 4 => 'r--', 3 => '-wx', 2 => '-w-', 1 => '--x', 0 => '---' }
  files.each do |file|
    file_info = File::Stat.new(file)
    print file_info.ftype[0]
    3.times { |n| print mode_hash[file_info.mode.to_s(8)[2, 3][n].to_i] }
    print "#{file_info.nlink}  "
    print "#{Etc.getpwuid(file_info.uid).name}  "
    print "#{Etc.getgrgid(file_info.gid).name}  "
    print "#{file_info.size}  "
    t = file_info.birthtime
    print "#{t.month}月  "
    print "#{t.day}  "
    print "#{t.hour.to_s.rjust(2, '0')}:#{t.hour.to_s.rjust(2, '0')}  "
    puts file
  end
end

def show_files(files)
  element_max_length = files.map(&:length).max
  row_separetion = 3
  new_line_position = (files.size.to_f / row_separetion).ceil # 折返し位置
  file_rows = []
  files.each_slice(new_line_position) do |row|
    file_rows << row
  end

  count = 0
  while count < new_line_position
    row_separetion.times do |i|
      if file_rows[i].nil? == false && file_rows[i][count].nil? == false
        print file_rows[i][count].ljust(element_max_length + 4, ' ')
      else
        print ''
      end
    end
    print "\n"
    count += 1
  end
end

main

#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
FOLDBACK = 3
MODES = { '7' => 'rwx', '6' => 'rw-', '5' => 'r-x', '4' => 'r--', '3' => '-wx', '2' => '-w-', '1' => '--x', '0' => '---' }.freeze
FILETYPES = { '01' => 'p', '02' => 'c', '04' => 'd', '06' => 'b', '10' => '-', '12' => 'l', '14' => 's' }.freeze

def show_file_names(file_names)
  line_count = (file_names.size.to_f / FOLDBACK).ceil
  max_word_length = file_names.map(&:length).max
  separated_files = file_names.each_slice(line_count).to_a
  line_count.times do |line_index|
    separated_files.each do |files|
      print files[line_index].ljust(max_word_length + 4) unless files[line_index].nil?
    end
    print "\n"
  end
end

def show_file_details(file_names)
  file_blocks = []
  file_nlinks = []
  file_owners = []
  file_groups = []
  file_sizes = []

  file_names.each do |file_name|
    file_detail = File.stat(file_name)
    file_blocks << file_detail.blocks
    file_nlinks << file_detail.nlink
    file_owners << Etc.getpwuid(file_detail.uid).name
    file_groups << Etc.getgrgid(file_detail.gid).name
    file_sizes << file_detail.size
  end
  total_blocks = file_blocks.sum
  max_file_nlink_length = file_nlinks.map(&:to_s).map(&:length).max
  max_file_owner_length = file_owners.map(&:to_s).map(&:length).max
  max_file_groupe_length = file_groups.map(&:to_s).map(&:length).max
  max_file_size_length = file_sizes.map(&:to_s).map(&:length).max

  puts "total #{total_blocks} "
  file_names.each do |file_name|
    file_detail = File.stat(file_name)
    mode_octal_number = format('%06d', file_detail.mode.to_s(8))
    print FILETYPES[mode_octal_number[0..1]]
    print "#{MODES[mode_octal_number.slice(-3)]}#{MODES[mode_octal_number.slice(-2)]}#{MODES[mode_octal_number.slice(-1)]} "
    print "#{file_detail.nlink.to_s.rjust(max_file_nlink_length)} "
    print "#{Etc.getpwuid(file_detail.uid).name.rjust(max_file_owner_length)}  "
    print "#{Etc.getgrgid(file_detail.gid).name.rjust(max_file_groupe_length)}  "
    print "#{file_detail.size.to_s.rjust(max_file_size_length)}  "
    print "#{file_detail.mtime.strftime('%_m %_d %H:%M')} "  if file_detail.mtime.year == Time.now.year
    print "#{file_detail.mtime.strftime('%_m %_d  %G')} " if file_detail.mtime.year < Time.now.year
    print file_name
    print "\n"
  end
end

opt = ARGV.getopts('a', 'r', 'l')
file_names =
  if opt['a']
    Dir.glob('*', File::FNM_DOTMATCH).sort
  elsif opt['r']
    Dir.glob('*').sort.reverse
  else
    Dir.glob('*').sort
  end
if opt['l']
  show_file_details(file_names)
else
  show_file_names(file_names)
end

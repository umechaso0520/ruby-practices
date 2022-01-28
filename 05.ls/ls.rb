#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
FOLDBACK = 3

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

opt = ARGV.getopts('r')
file_names =
  if opt['r']
    Dir.glob('*').sort.reverse
  else
    Dir.glob('*').sort
  end
show_file_names(file_names)

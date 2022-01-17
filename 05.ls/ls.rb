#!/usr/bin/env ruby
# frozen_string_literal: true

file_names = Dir.glob('*').sort
FOLDBACK = 3
line_count = (file_names.size.to_f / FOLDBACK).ceil
max_word_length = file_names.map(&:length).max

separated_files = file_names.each_slice(line_count).to_a

line_count.times do |line_index|
  separated_files.each do |files|
    print files[line_index].ljust(max_word_length + 4) unless files[line_index].nil?
  end
  print "\n"
end

#!/usr/bin/env ruby
# frozen_string_literal: true

files = Dir.glob('*').sort
foldback = 3
row = (files.size.to_f / foldback).ceil
max_length_word = files.map(&:length).max

file_separation = []
files.each_slice(row) { |element| file_separation << element }

row.times do |count|
  file_separation.each do |i|
    next if i[count].nil?

    print i[count].ljust(max_length_word + 4)
  end
  print "\n"
end

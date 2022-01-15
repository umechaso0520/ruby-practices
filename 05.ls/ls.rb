#!/usr/bin/env ruby
# frozen_string_literal: true

FILES = Dir.glob('*').sort
FOLDBACK = 3
number_of_lines = (FILES.size.to_f / FOLDBACK).ceil
maximum_word_length = FILES.map(&:length).max

separated_files = []
FILES.each_slice(number_of_lines) { |file| separated_files << file }

number_of_lines.times do |line|
  separated_files.each do |file|
    print file[line].ljust(maximum_word_length + 4) unless file[line].nil?
  end
  print "\n"
end

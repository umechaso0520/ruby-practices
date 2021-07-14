#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0 if shots.size < 18
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end
frames[-2].concat(frames[-1])
frames.delete_at(-1)

point = frames.each_with_index.sum do |frame, index|
  if index < 9 # 9ゲーム目までの処理
    if frame[0] == 10 # ストライクの場合
      if frames[index + 1][0] == 10
        if index < 8
          10 + 10 + frames[index + 2][0]
        else
          10 + 10 + frames[index + 1][1]
        end
      else
        10 + frames[index + 1][0] + frames[index + 1][1]
      end
    elsif frame[0] != 10 && frame.sum == 10 # スペアの場合
      10 + frames[index + 1][0]
    else
      frame.sum
    end
  else
    frame.sum
  end
end
puts point

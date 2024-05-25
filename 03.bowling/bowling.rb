# frozen_string_literal: true

scores = ARGV[0].split(',')
frames = []
current_frame = []
scores.each do |score|
  score = score == 'X' ? 10 : score.to_i
  if frames.length == 9
    current_frame.push(score)
    next
  end
  if score == 10 && current_frame.empty?
    frames.push([10])
    next
  else
    current_frame.push(score)
  end
  if current_frame.length == 2
    frames.push(current_frame)
    current_frame = []
  end
end
frames.push(current_frame)

point = 0
frames.each_with_index do |frame, index|
  first = frame[0]
  second = frame[1]
  third = frame[2]
  if index <= 8
    if first == 10 # strike
      point += 10
      point += frames[index + 1][0]
      point += if frames[index + 1][1].nil?
                 frames[index + 2][0]
               else
                 frames[index + 1][1]
               end
    elsif frame.sum == 10 # spare
      point += 10
      point += frames[index + 1][0]
    else
      point += first
      point += second
    end
  else # 最終フレーム
    point += first
    point += second if !second.nil?
    point += third if !third.nil?
  end
end
puts point

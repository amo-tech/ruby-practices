# frozen_string_literal: true

scores = ARGV[0].split(',').map{|score| score == 'X' ? 10 : score.to_i}
frames = []
current_frame = []
scores.each do |score|
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
  first, second, third = frame[0], frame[1], frame[2]
  strike_point = 10
  point += first
  point += second if !second.nil?
  point += third if !third.nil?

  if index <= 8
    if first == strike_point # strike
      point += frames[index + 1][0]
      point += if frames[index + 1][1].nil?
                 frames[index + 2][0]
               else
                 frames[index + 1][1]
               end
    elsif frame.sum == strike_point # spare
      point += frames[index + 1][0]
    end
  end
end
puts point

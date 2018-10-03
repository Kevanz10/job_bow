class FrameScore

  MAX_PINFALLS_IN_A_GAME = "10".freeze

  def self.calculate(player_frames)
    if perfect_game?(player_frames)
      [perfect_game_scores, pinfall_equal_generator("X")]
    else
      scores = normal_game_calculator(player_frames)
      [scores[0], scores[1]]
    end
  end

  def self.perfect_game_scores
    scores = [30]
    (0..8).each do |number|
      scores << scores[number] + 30
    end
    scores
  end

  def self.normal_game_calculator player_frames
    points = []
    pinfalls = []
    player_frames.each_with_index do |score, index|
      total = 0
      if strike? score
        total = score.to_i
        total += strike_calculator(player_frames[index + 1], player_frames[index + 2])
        index == (player_frames.size - 2) ? pinfalls << ["X", player_frames[index+1]] : pinfalls << "X"
      elsif spare? score
        total += spare_calculator(score, player_frames[index + 1])
        sign = pinfall_identifier(score[1])
        pinfalls << [score[0], sign]
      elsif normal? score
        total += frame_add(score[0],score[1])
        pinfalls << [score[0], score[1]]
      end
      points << total + (points[index - 1] || 0)
      break if index == 9
    end
    return [points, pinfalls]
  end

  def self.perfect_game? scores
    scores.all? {|score| score == MAX_PINFALLS_IN_A_GAME} 
  end

  def self.pinfall_equal_generator(letter)
    pinfalls = []; 10.times { pinfalls << "#{letter}"}
    pinfalls
  end

  def self.strike? score
    score.is_a? String
  end

  def self.strike_calculator next_frame, second_next
    total = 0
    if next_frame != MAX_PINFALLS_IN_A_GAME            
      total += frame_add(next_frame[0], next_frame[1])
    else  
      second_next == MAX_PINFALLS_IN_A_GAME ? second_next = second_next.to_i : second_next = second_next[0].to_i
      total += 10 + second_next
    end
    total
  end

  def self.spare? score
    score.is_a?(Array) && (score[0].to_i + score[1].to_i == 10)  
  end

  def self.spare_calculator current_frame, next_frame
    frame_add(current_frame[0], current_frame[1]) + next_frame[0].to_i 
  end

  def self.pinfall_identifier(score)
    score != "F" ? "/" : "F"
  end

  def self.normal? score
    score.is_a?(Array) && (score[0].to_i + score[1].to_i < 10)
  end

  def self.frame_add(point1, point2)
    point1.to_i + point2.to_i
  end
end
require 'byebug'
require_relative 'frame_score'

class Organizer
  def self.pinfalls_per_frame pinfalls
    formated_array = [] 
    new_array = []
    new_array = pinfalls
    new_array.each_with_index do |pinfall, index|
      if pinfall == FrameScore::MAX_PINFALLS_IN_A_GAME
        formated_array << pinfall
      else
        formated_array << [pinfalls[index], pinfalls[index + 1]]
        new_array.delete_at(index + 1) if index != pinfalls.size + 1
      end
    end
    formated_array
  end
end
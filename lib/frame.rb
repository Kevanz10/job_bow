require_relative 'organizer'
class Frame
  attr_accessor :pinfalls
  
  def initialize pinfalls
    @pinfalls = pinfalls
  end

  def calculate_frame_scores
    pinfalls_per_frame
  end

  private
    def pinfalls_per_frame
      Organizer.pinfalls_per_frame(@pinfalls)
    end
end
require_relative 'user'
require_relative 'organizer'
class Frame
  attr_accessor :player, :pinfalls, :scores, :games, :chances

  def initialize player, pinfalls
    @player = player
    @scores = []
    @pinfalls = pinfalls
    @games = []
  end

  def calculate_frame_scores
    frames = pinfalls_per_frame
  end

  private
    def pinfalls_per_frame
      Organizer.pinfalls_per_frame(@pinfalls)
    end
end
require_relative 'user'
require_relative 'frame'
require_relative 'frame_score'
require_relative 'scoreboard_table'

class Bowling
  attr_accessor :frame_points, :scores, :pinfalls, :names
  def initialize file
    @file = file
    @points = User.scores(@file)
    @frame_points = []
    @scores = []
    @pinfalls = []
    @names = []
  end

  def play
    board
    get_names
    @frame_points.each do |player_frames|
      score = FrameScore.calculate(player_frames)
      @scores << score[0]
      @pinfalls << score[1]
    end
    scoreboard_table = ScoreboardTable.new(@scores, @pinfalls, @names)
    scoreboard_table.board
  end

  private
    def board
      points = @points.each do |player, pinfalls|
        frame = Frame.new(pinfalls)
        frame = frame.calculate_frame_scores
        @frame_points << frame
      end
    end

    def get_names 
      @points.select { |key,_| @names << key }
    end
end

file = ARGV.first
board = Bowling.new(file)
board.play



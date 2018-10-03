require "././lib/bowling"
require "././lib/user"
require "byebug"
RSpec.describe "Bowling" do
  let(:normal_game_file) {"games/normal_bowling-game.txt"}
  let(:bowling_game){ Bowling.new(normal_game_file) }

  describe "calculatore_scores" do
    let(:board) {"Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10\t\t\nJeff\t\t\nPinfalls\t\tX\t7 \t / \t9 \t 0 \t\tX\t0 \t 8 \t8 \t / \tF \t 6 \t\tX\t\tX\tX \t 8 \t 1\nScore\t\t20\t\t39\t\t48\t\t66\t\t74\t\t84\t\t90\t\t120\t\t148\t\t167\t\t\n\John\t\t\nPinfalls\t3 \t / \t6 \t 3 \t\tX\t8 \t 1 \t\tX\t\tX\t9 \t 0 \t7 \t / \t4 \t 4 \tX \t 9 \t 0\nScore\t\t16\t\t25\t\t44\t\t53\t\t82\t\t101\t\t110\t\t124\t\t132\t\t151\t\t\n"}
    it "promts the bowling scoreboard" do
      expect {bowling_game.play}.to output(board).to_stdout
    end
  end
end
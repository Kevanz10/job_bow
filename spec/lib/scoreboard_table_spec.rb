require "././lib/scoreboard_table.rb"
RSpec.describe "ScoreboardTable" do

  let(:scores_normal) {[[20, 39, 48, 66, 74, 84, 90, 120, 148, 167], [16, 25, 44, 53, 82, 101, 110, 124, 132, 151]]}
  let(:scores_perfect) {[[30, 60, 90, 120, 150, 180, 210, 240, 270, 300]]}
  let(:scores_all_zero){[[0,0,0,0,0,0,0,0,0,0]]}

  let(:names) {["Jeff", "John"]}
  let(:pinfalls_normal_scores){[["X", ["7", "/"], ["9", "0"], "X", ["0", "8"], ["8", "/"], ["F", "6"], "X", "X", 
                  ["X", ["8", "1"]]],  [["3", "/"], ["6", "3"], "X", ["8", "1"], "X", "X", ["9", "0"], ["7", "/"],
                   ["4", "4"], ["X", ["9", "0"]]]
                ]}
  let(:pinfalls_perfect_scores){[["X", "X", "X", "X", "X", "X", "X", "X", "X", "X"]] }
  let(:pinfalls_all_foul_scores){[["F", "F", "F", "F", "F", "F", "F", "F", "F", "F"]]}
  let(:pinfalls_all_zero_scores){[["0", "0", "0", "0", "0", "0", "0", "0", "0", "0"]] }
  let(:scoreboard_table) { ScoreboardTable.new(scores_normal, pinfalls_normal_scores, names) }
  let(:board_name) {["Jeff"]}

  describe "#frame" do
    let(:frame_row) {"Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10\t\t\n"}
    context "when the method is called" do
      it "returns the total frames rows separated by whitespaces" do
        expect {ScoreboardTable.frame}.to output(frame_row).to_stdout
      end
    end
  end

  describe ".player_name" do
    let(:first_player_name_row){"Jeff\t\t\n"}
    let(:second_player_name_row){"John\t\t\n"}
    context "when the method is called" do
      it "returns the name of the first player in a new row" do
        expect {scoreboard_table.player_name 0}.to output(first_player_name_row).to_stdout
      end
      it "returns the name of the second player in a new row" do
        expect {scoreboard_table.player_name 1}.to output(second_player_name_row).to_stdout
      end
    end
  end
  
  describe ".pinfalls" do
    let(:first_player_pinfall_row){"Pinfalls\t\t7\t\t/\t\n"}
    let(:second_player_pinfall_row){"Jeff\t\t\n"}
    let(:first_pinfall_scores){"Pinfalls\t\tX\t7 \t / \t9 \t 0 \t\tX\t0 \t 8 \t8 \t / \tF \t 6 \t\tX\t\tX\tX \t 8 \t 1\n"}
    let(:second_pinfall_scores){"Pinfalls\t3 \t / \t6 \t 3 \t\tX\t8 \t 1 \t\tX\t\tX\t9 \t 0 \t7 \t / \t4 \t 4 \tX \t 9 \t 0\n"}
    context "when the game has normal scores" do
      it "returns pinfall's format score of the first user in a new row" do
        expect {scoreboard_table.pinfalls(0)}.to output(first_pinfall_scores).to_stdout
      end
      it "returns pinfall's format score of the second user in a new row" do
        expect {scoreboard_table.pinfalls(1)}.to output(second_pinfall_scores).to_stdout
      end
    end
    context "when is a perfect game" do
      let(:scoreboard_table) { ScoreboardTable.new(scores_perfect, pinfalls_perfect_scores, names) }
      let(:pinfalls_perfect_game){"Pinfalls\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\n"}
      it "returns pinfall's format score of the user in a new row" do
        expect {scoreboard_table.pinfalls(0)}.to output(pinfalls_perfect_game).to_stdout
      end
    end

    context "when is a all fouls game" do
      let(:scoreboard_table) { ScoreboardTable.new(scores_perfect, pinfalls_all_foul_scores, names) }
      let(:pinfalls_all_fouls){"Pinfalls\t\tF\t\tF\t\tF\t\tF\t\tF\t\tF\t\tF\t\tF\t\tF\t\tF\t\n"}
      it "returns pinfall's format score of the user in a new row" do
        expect {scoreboard_table.pinfalls(0)}.to output(pinfalls_all_fouls).to_stdout
      end
    end

    context "when is a all zero game" do
      let(:scoreboard_table) { ScoreboardTable.new(scores_perfect, pinfalls_all_zero_scores, names) }
      let(:pinfalls_all_zeros){"Pinfalls\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\n"}
      it "returns pinfall's format score of the user in a new row" do
        expect {scoreboard_table.pinfalls(0)}.to output(pinfalls_all_zeros).to_stdout
      end
    end
  end

  describe ".score" do
    context "when the game has normal scores" do
      let(:first_user_score) {"Score\t\t20\t\t39\t\t48\t\t66\t\t74\t\t84\t\t90\t\t120\t\t148\t\t167\t\t\n"}
      let(:second_user_score) {"Score\t\t16\t\t25\t\t44\t\t53\t\t82\t\t101\t\t110\t\t124\t\t132\t\t151\t\t\n"}
      it "returns the score's of the first user in a new row" do
        expect {scoreboard_table.score 0}.to output(first_user_score).to_stdout
      end
      it "returns the score's of the second user in a new row" do
        expect {scoreboard_table.score 1}.to output(second_user_score).to_stdout
      end
    end  

    context "when the game is has all foul scores" do
      let(:scoreboard_table) { ScoreboardTable.new(scores_all_zero, pinfalls_all_foul_scores, names) }
      let(:first_user_score) {"Score\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t\n"}
      it "returns the score's of the first user in a new row" do
        expect {scoreboard_table.score 0}.to output(first_user_score).to_stdout
      end
    end 

    context "when the game is has all zeros scores" do
      let(:scoreboard_table) { ScoreboardTable.new(scores_all_zero, pinfalls_all_foul_scores, names) }
      let(:first_user_score) {"Score\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t\n"}
      it "returns the score's of the first user in a new row" do
        expect {scoreboard_table.score 0}.to output(first_user_score).to_stdout
      end
    end  

    context "when the game is has perfect scores" do
      let(:scoreboard_table) { ScoreboardTable.new(scores_perfect, pinfalls_perfect_scores, names) }
      let(:first_user_score) {"Score\t\t30\t\t60\t\t90\t\t120\t\t150\t\t180\t\t210\t\t240\t\t270\t\t300\t\t\n"}
      it "returns the score's of the first user in a new row" do
        expect {scoreboard_table.score 0}.to output(first_user_score).to_stdout
      end
    end   
  end

  describe ".board" do
    context "when the game has normal scores" do
      let(:board_table){"Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10\t\t\nJeff\t\t\nPinfalls\t\tX\t7 \t / \t9 \t 0 \t\tX\t0 \t 8 \t8 \t / \tF \t 6 \t\tX\t\tX\tX \t 8 \t 1\nScore\t\t20\t\t39\t\t48\t\t66\t\t74\t\t84\t\t90\t\t120\t\t148\t\t167\t\t\n\John\t\t\nPinfalls\t3 \t / \t6 \t 3 \t\tX\t8 \t 1 \t\tX\t\tX\t9 \t 0 \t7 \t / \t4 \t 4 \tX \t 9 \t 0\nScore\t\t16\t\t25\t\t44\t\t53\t\t82\t\t101\t\t110\t\t124\t\t132\t\t151\t\t\n"}
      it "returns the scoreboard of a normal game" do
        expect {scoreboard_table.board}.to output(board_table).to_stdout
      end
    end

    context "when the game has all foul scores" do
      let(:pinfalls_all_foul_scores) {[[["F", "F"], ["F", "F"], ["F", "F"], ["F", "F"], ["F", "F"], ["F", "F"], ["F", "F"], ["F", "F"], ["F", "F"], ["F", "F"]]]}
      let(:scoreboard_table) { ScoreboardTable.new(scores_all_zero, pinfalls_all_foul_scores, board_name) }
      let(:board_table){"Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10\t\t\nJeff\t\t\nPinfalls\tF \t F \tF \t F \tF \t F \tF \t F \tF \t F \tF \t F \tF \t F \tF \t F \tF \t F \tF \t F \t \nScore\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t\n"}
      it "returns the scoreboard of all foul's game" do
        expect {scoreboard_table.board}.to output(board_table).to_stdout
      end
    end

    context "when the game is a perfect game" do
      let(:scoreboard_table) { ScoreboardTable.new(scores_perfect, pinfalls_perfect_scores, board_name) }
      let(:board_table){"Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10\t\t\nJeff\t\t\nPinfalls\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\nScore\t\t30\t\t60\t\t90\t\t120\t\t150\t\t180\t\t210\t\t240\t\t270\t\t300\t\t\n"}
      it "returns the scoreboard of a perfect game" do
        expect {scoreboard_table.board}.to output(board_table).to_stdout
      end
    end

    context "when the game is has all zero scores" do
      let(:pinfalls_all_zeros_scores) {[[["0", "0"], ["0", "0"], ["0", "0"], ["0", "0"], ["0", "0"], ["0", "0"], ["0", "0"], ["0", "0"], ["0", "0"], ["0", "0"]]]}
      let(:scoreboard_table) { ScoreboardTable.new(scores_all_zero, pinfalls_all_zeros_scores, board_name) }
      let(:board_table){"Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10\t\t\nJeff\t\t\nPinfalls\t0 \t 0 \t0 \t 0 \t0 \t 0 \t0 \t 0 \t0 \t 0 \t0 \t 0 \t0 \t 0 \t0 \t 0 \t0 \t 0 \t0 \t 0 \t \nScore\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t\n"}
      it "returns the scoreboard of a all zero's game" do
        expect {scoreboard_table.board}.to output(board_table).to_stdout
      end
    end
  end
end

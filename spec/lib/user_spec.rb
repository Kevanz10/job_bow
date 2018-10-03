require "././lib/user"

RSpec.describe "User" do
  describe ".scores" do
    let(:all_foul_game) { "games/all_foul_game.txt" }
    let(:all_zero_game) { "games/all_zero_game.txt" }
    let(:normal_game) { "games/normal_bowling-game.txt" }
    let(:perfect_game) { "games/perfect_game.txt" }

    let(:all_foul_game_scores) {
      { "Jeff" => [ "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F",
                    "F", "F", "F", "F", "F", "F", "F", "F", "F"] }
    }

    let(:all_zeros_game_scores) {
      { "Jeff" => [ "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
                    "0", "0", "0", "0", "0", "0", "0", "0", "0"] }
    }

    let(:normal_game_scores) {
      {"Jeff"=>["10", "7", "3", "9", "0", "10", "0", "8", "8", "2", "F", "6", "10", "10", "10", "8", "1"], 
        "John"=>["3", "7", "6", "3", "10", "8", "1", "10", "10", "9", "0", "7", "3", "4", "4", "10", "9", "0"]
      }
    }

    let(:perfect_game_scores) {
      { "Jeff" => ["10", "10", "10", "10", "10", "10", "10", "10", "10", "10", "10", "10"] }
    }    

  
    context "when the file has a full foul game" do
      let(:player_scores) { User.scores(all_foul_game)}
      
      it "returns players score" do
        expect(player_scores).to eq all_foul_game_scores
      end
    end

    context "when the file has all zeros" do
      let(:player_scores) { User.scores(all_zero_game)}

      it "returns players score" do
        expect(player_scores).to eq all_zeros_game_scores
      end
    end

    context "when the file has a normal game" do
      let(:player_scores) { User.scores(normal_game)}

      it "returns players score" do
        expect(player_scores).to eq normal_game_scores
      end
    end

    context "when the file has a perfect game" do
      let(:player_scores) { User.scores(perfect_game)}

      it "returns players score" do
        expect(player_scores).to eq perfect_game_scores
      end
    end
  end
end

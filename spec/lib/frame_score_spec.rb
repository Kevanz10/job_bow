require "././lib/frame_score"

RSpec.describe "FrameScore" do
  let(:perfect_game_scores) { ["10", "10", "10", "10", "10", "10", "10", "10", "10", "10"]}
  let(:normal_game_scores) {["10", ["7", "3"], ["9", "0"], "10", ["0", "8"], ["8", "2"], ["F", "6"], "10", "10", "10", ["8", "1"]]}
  
  describe ".perfect_game?" do
    let(:is_perfect){FrameScore.perfect_game? perfect_game_scores}
    let(:is_not_perfect){FrameScore.perfect_game? normal_game_scores}
    context "when all the frame's scores are passed" do
      it "returns true if all frames are 10" do
        expect(is_perfect).to eq true
      end
      it "returns false if all frames are not 10" do
        expect(is_not_perfect).to eq false
      end
    end
  end

  describe ".perfect_game_scores" do
    let(:frame_perfect_score){FrameScore.perfect_game_scores}
    let(:perfect_score) {[30, 60, 90, 120, 150, 180, 210, 240, 270, 300]}
    context "when method is called" do
      it "creates the score of a perfect game" do
        expect(frame_perfect_score).to eq perfect_score
      end
    end
  end

  describe ".strike?" do
    let(:strike){FrameScore.strike? "10"}
    let(:not_strike){FrameScore.strike? ["1", "9"]}
    context "when the frame score is pass" do
      it "returns true if it's a strike" do
        expect(strike).to eq true
      end
      it "returns false if it's not a strike" do
        expect(not_strike).to eq false
      end
    end
  end

  describe ".spare?" do
    let(:spare){FrameScore.spare? ["1", "9"]}
    let(:not_spare){FrameScore.spare? ["0", "9"]}
    context "when the frame score is pass" do
      it "returns true if it's a spare" do
        expect(spare).to eq true
      end
      it "returns false if it's not a spare" do
        expect(not_spare).to eq false
      end
    end
  end

  describe ".spare_calculator" do
    let(:spare){FrameScore.spare_calculator ["1", "9"], "1"}
    context "when the frame score is a spare" do
      it "returns the spare score frame" do
        expect(spare).to eq 11
      end
    end
  end

  describe ".pinfall_identifier" do
    let(:foul){FrameScore.pinfall_identifier "F" }
    let(:spare){FrameScore.pinfall_identifier "1"}
    context "when the frame score is a spare" do
      it "returns f when it's a foul" do
        expect(foul).to eq "F"
      end
      it "returns / if it's a spare" do
        expect(spare).to eq "/"
      end
    end
  end

  describe ".pinfall_equal_generator" do
    let(:pinfall_perfect_game){["X", "X", "X", "X", "X", "X", "X", "X", "X", "X"]}
    let(:pinfall_score){FrameScore.pinfall_equal_generator "X"}
    context "when is a perfect game" do
      it "generate the pinfall's score" do
        expect(pinfall_score).to eq pinfall_perfect_game
      end
    end
  end

  describe ".normal?" do
    let(:normal){FrameScore.normal? ["1", "8"]}
    let(:not_normal){FrameScore.normal? ["1", "9"]}
    context "when the frame score is pass" do
      it "returns true if the pinfalls are below 10" do
        expect(normal).to eq true
      end
      it "returns false if the pinfalls are below 10" do
        expect(not_normal).to eq false
      end
    end
  end

  describe ".frame_add" do
    context "when the frame score is pass" do
      let(:add){FrameScore.frame_add "1", "8"}
      it "adds the value of the pinfalls" do
        expect(add).to eq 9
      end
    end
  end

  describe ".normal_game_calculator" do
    let(:result){[[20, 39, 48, 66, 74, 84, 90, 120, 148, 167], 
      ["X", ["7", "/"], ["9", "0"], "X", ["0", "8"], ["8", "/"], ["F", "6"], "X", "X", ["X", ["8", "1"]]]]}
    context "when the frame score is pass" do
      it "return an array with the point and the pinfall's score of the game" do
        expect(FrameScore.normal_game_calculator normal_game_scores).to eq result
      end
    end
  end

  describe ".strike_calculator" do
    context "when is not a double strike" do
      it "adds the score with of the next frame" do
        expect(FrameScore.strike_calculator([3, 6], [2, 3])).to eq(9)
      end
    end

    context "when is a double strike" do
      it "adds the score of the next frames" do
        expect(FrameScore.strike_calculator("10", [2, 3])).to eq(12)
      end
    end    
  end

  describe ".calculate" do
    context "when its a perfect game" do
      let(:perfect_game) {[[30, 60, 90, 120, 150, 180, 210, 240, 270, 300], ["X", "X", "X", "X", "X", "X", "X", "X", "X", "X"]]}
      it "returns the score and the pinfalls of the game" do
        expect(FrameScore.calculate(perfect_game_scores)).to eq(perfect_game)
      end
    end

    context "when its a normal game" do
      let(:result_normal_game_scores) {[[20, 39, 48, 66, 74, 84, 90, 120, 148, 167], ["X", ["7", "/"], ["9", "0"], "X", ["0", "8"], ["8", "/"], ["F", "6"], "X", "X", ["X", ["8", "1"]]]]}
      it "returns the score and the pinfalls of the game" do
        expect(FrameScore.calculate(normal_game_scores)).to eq(result_normal_game_scores)
      end
    end
  end

end

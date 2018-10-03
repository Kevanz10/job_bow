require "././lib/organizer"

RSpec.describe "Organizer" do
  describe ".pinfalls_per_frame" do
    let(:foul_scores) { ["F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", 
                                "F", "F", "F", "F", "F", "F", "F", "F"] }
    let(:zero_scores) { ["0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
                         "0", "0", "0", "0", "0", "0", "0"] }
    let(:normal_scores) { ["10", "7", "3", "9", "0", "10", "0", "8", "8", "2", "F", "6", "10", "10", 
                        "10", "8", "1"] }
    let(:perfect_scores) { ["10", "10", "10", "10", "10", "10", "10", "10", "10", "10", "10", "10"] }
    let(:normal_frame_scores) {
      ["10", ["7", "3"], ["9", "0"], "10", ["0", "8"], ["8", "2"], ["F", "6"], "10", "10", "10", ["8", "1"]]}
    let(:foul_game_frames){ [["F", "F"], ["F", "F"], ["F", "F"], ["F", "F"], 
                              ["F", "F"], ["F", "F"], ["F", "F"], 
                            ["F", "F"], ["F", "F"], ["F", "F"], ["F", nil]]}
    let(:zero_scores_frames) { [["0", "0"], ["0", "0"], ["0", "0"], 
                              ["0", "0"], ["0", "0"], ["0", "0"], ["0", "0"], 
                              ["0", "0"], ["0", "0"], ["0", "0"], ["0", nil]] }

    context "when scores are from a normal game" do
      let(:frame_scores) { Organizer.pinfalls_per_frame(normal_scores) }
      it "returns scores grouped per frame" do
        expect(frame_scores).to eq normal_frame_scores
      end
    end

    context "when scores are from a full foul game" do
      let(:frame_scores) { Organizer.pinfalls_per_frame(foul_scores)}
      it "returns scores grouped per frame" do
        expect(frame_scores).to eq foul_game_frames
      end
    end

    context "when scores are from a full zero game" do
      let(:frame_scores) { Organizer.pinfalls_per_frame(zero_scores)}
      it "returns scores grouped per frame" do
        expect(frame_scores).to eq zero_scores_frames
      end
    end

    context "when scores are from a pefect game" do
      let(:frame_scores) { Organizer.pinfalls_per_frame(perfect_scores) }
      it "returns scores grouped per frame" do
        expect(frame_scores).to eq perfect_scores
      end
    end
  end
end

require "././lib/frame"

RSpec.describe "Frame" do
  let(:normal_game){ ["10", "7", "3", "9", "0", "10", "0", "8", "8", "2", "F", "6", "10", "10", "10", "8", "1"]}

  let(:normal_game_by_frames){["10", ["7", "3"], ["9", "0"], "10", ["0", "8"], ["8", "2"], 
                              ["F", "6"], "10", "10", "10", ["8", "1"]]}
  describe "#calculate_frame_scores" do
    context "when the scores of a normal game are recieved" do
      it "organizes them by frames" do
        frame = Frame.new(normal_game)
        expect(frame.calculate_frame_scores).to eq normal_game_by_frames
      end
    end
  end
end
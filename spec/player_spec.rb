require 'player'

describe Player do

  let(:player) { Player.new }
  let(:view) { View.new }

  describe "#initialize" do
    it "is of class Player" do
      expect(player.class).to eq(Player)
    end
  end

  describe "#assign_move" do

    context "player wants to move" do
      before do
        allow(player).to receive(:gets).and_return("1,2")
      end

      it "gets move and returns player input" do
        expect(player.assign_move).to eq([1,2])
      end

      it "calls #valid_input?" do
        allow(player).to receive(:valid_input?).and_return(true)
        expect(player).to receive(:valid_input?)
        player.assign_move
      end


      it "calls assign_move if move is not valid" do
        allow(player).to receive(:valid_input?).and_return(false)
        expect(player).to receive(:assign_move)
        player.assign_move
      end
    end

    context "player wants to add flag" do
       before do
        allow(player).to receive(:gets).and_return("1,2")
      end

      it "gets input and returns player input" do
        expect(player.assign_flag_location).to eq([1,2])
      end

      it "calls #valid_input?" do
        allow(player).to receive(:valid_input?).and_return(true)
        expect(player).to receive(:valid_input?)
        player.assign_flag_location
      end

      it "calls assign_flag_location if move is not valid" do
        allow(player).to receive(:valid_input?).and_return(false)
        expect(player).to receive(:assign_flag_location)
        player.assign_flag_location
      end

    end

  end
end

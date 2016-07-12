require 'player'

describe Player do
  
  let(:player) { Player.new }
  let(:view) { View.new }

  describe "#initialize" do
    it "is of class Player" do
      expect(player.class).to eq(Player)
    end
  end

  describe "#assign_input" do
    it "calls view.ask_for_move" do
      expect(view).to receive(:ask_fo_move)
    end
    
    context "player wants to add flag" do
      it "calls View::ask_where_to_put_flag"
      it "returns place to put flag"
    end

    context "player wants to move" do
      it "call valid move?"
      it "should return move if move is valid"
      it "should ask for move again if move is not valid"
      it "adds flag to correct location"
    end
    
  end
end
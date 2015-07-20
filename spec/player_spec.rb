require 'player'

context Player do

  describe "#get_coords" do
    it "gets and validates format of coordinates for a cell from the player" do
      allow( subject ).to receive(:gets).and_return("bad", "still bad", "1,1")
      allow( subject ).to receive(:print)
      expect( subject.get_coords ).to eq( [1,1] )
    end
  end

  describe "#get_move" do
    it "asks the player if they want to flag or reveal the cell, returns :flag if f" do
      allow( subject ).to receive(:gets).and_return("bad", "still bad", "f")
      allow( subject ).to receive(:print)
      expect( subject.get_action ).to eq( :flag )
    end

    it "asks the player if they want to flag or reveal the cell, returns :reveal if r" do
      allow( subject ).to receive(:gets).and_return("bad", "still bad", "r")
      allow( subject ).to receive(:print)
      expect( subject.get_action ).to eq( :reveal )
    end
  end
  
end
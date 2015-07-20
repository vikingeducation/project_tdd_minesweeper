require 'player'

context Player do

  describe "#get_coords" do
    it "gets coordinates for a cell from the player" do
      allow( subject ).to receive(:gets).and_return("bad", "still bad", "1,1")
      expect( subject.get_coords ).to eq( [1,1] )
    end
    
  end
  
end
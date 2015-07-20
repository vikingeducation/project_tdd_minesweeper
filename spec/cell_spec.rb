require 'cell'

describe Cell do

  context "#initialize new cell" do

    it "is covered" do
      expect( subject.covered? ).to be true
    end

    it "is not flagged" do
      expect( subject.flagged? ).to be false
    end

    it "is not mined" do
      expect( subject.mined? ).to be false
    end

    it "has 0 mined neighbors" do
      expect( subject.mined_neighbors ).to eq(0)
    end

  end
    
  context "changing state" do
        
    it "#reveal! sets the tile to not be covered" do
      subject.reveal!
      expect( subject.covered? ).to be false
    end

    it "#flag! sets the tile to flagged" do
      subject.flag!
      expect( subject.flagged? ).to be true
    end

    it "#flag! removes the flag from an already flagged cell" do
      subject.flag!
      subject.flag!
      expect( subject.flagged? ).to be false
    end

    it "#mine! sets the tile to mined" do
      subject.mine!
      expect( subject.mined? ).to be true
    end
  
  end
  
end
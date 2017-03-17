require "player"

describe Player do 

  let(:player) { Player.new }

  describe "#initialize" do 
    it "creates a new player with an instance variable row set to nil" do
      expect(player.row).to eq(nil)
    end

    it "sets the instance variable column to nil" do 
      expect(player.column).to eq(nil)
    end

    it "sets the instance variable move_type to nil" do 
      expect(player.marker).to eq(nil)
    end
  end

  describe "#row_move" do 
    it "asks the user for row coordinates " do 
      allow(player).to receive(:gets).and_return("1")
      player.row_move
    end
  end

  describe "#col_move" do 
    it "asks the user for column coordinates" do 
      allow(player).to receive(:gets).and_return("2")
      player.col_move
    end
  end

  describe "#valid_coordinates?" do 
    it "returns true if row and column is between 1-10" do 
      expect(player.valid_coordinates?(1, 2)).to be true
    end

    it "returns false if row is greater than 10" do 
      expect(player.valid_coordinates?(11, 2)).to be false
    end

    it "returns false if column is greater than 10" do 
      expect(player.valid_coordinates?(5, 12)).to be false
    end
  end

  describe "#set_coordinates" do
    before do 
      player.set_coordinates(1, 10)      
    end

    it "sets the instance variable row to valid row number" do 
      expect(player.row).to eq(0)
    end

    it "sets the instance variable column to valid column number" do 
      expect(player.column).to eq(9)
    end
  end

  describe "#open_or_flag" do
    it "returns a response from the player" do
      allow(player).to receive(:gets).and_return("f")
      player.open_or_flag
    end
  end

  describe "#vaid_response?" do 
    it "returns true if response is 'f'" do 
      expect(player.valid_response?("f")).to be true
    end

    it "returns true if response is 'o'" do 
      expect(player.valid_response?("o")).to be true
    end

    it "returns false if response is 'n'" do 
      expect(player.valid_response?("n")).to be false
    end
  end

  describe "#set_marker" do 
    it "sets the instance variable marker to :F" do 
      player.set_marker("f")
      expect(player.marker).to eq(:F)
    end

    it "sets the instance variable marker to :O" do 
      player.set_marker("o")
      expect(player.marker).to eq(:O)
    end
  end

end










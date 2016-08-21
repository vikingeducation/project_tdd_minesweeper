require 'minesweeper'

describe Minesweeper::Square do
  let(:coord){[0,0]}
  let(:map){[[2,2],[1,3],[1,1],[0,1]]}
  let(:square){Minesweeper::Square.new(coord, map)}

  describe "initialize" do
    it "creates a new square" do
      expect(square).to be_a(Minesweeper::Square)
    end
  end

  describe "#change_flag" do
    it "sets flag to true if flag was false" do
      square.change_flag
      expect(square.flag).to be true
    end
    it "sets flag to false if flag was true" do
      square.change_flag
      square.change_flag
      expect(square.flag).to be false
    end
  end

  describe "#add_mine" do
    it "sets mine to true" do
      square.add_mine
      expect(square.reveal).to eq nil
    end
  end

  describe "#reveal" do
    it "sets showing to true if no mine is present" do
      square.reveal
      expect(square.showing).to be true
    end
  end

  describe "#count_mines" do
    it "returns the number of surrounding mines" do
      expect(square.surround).to eq(2)
    end
  end
end

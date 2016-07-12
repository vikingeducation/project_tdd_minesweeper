require 'minesweeper'


describe Square do
  let(:coord){[1,2]}
  let(:map){[[2,2],[6,8]]}
  let(:square){Square.new(coord, map)}

  describe "initialize" do
    it "creates a new square" do
      expect(square).to be_a(Square)
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
      expect(square.mine).to be true
    end
  end

  describe "#reveal" do
    it "sets showing to true" do
      square.reveal
      expect(square.showing).to be true
    end
  end

  describe "#count_mines" do

  end
end

require 'square'

describe Square do

  describe "#initialize" do
      let(:square) { Square.new(2,4) }

      it "starts with @x from first argument" do
        expect(square.x).to eq(2)
      end

      it "starts with @y from second argument" do
        expect(square.y).to eq(4)
      end

      it "starts with @cleared, @flagged both false" do
        expect(square.cleared).to be_falsey
        expect(square.flagged).to be_falsey
      end

  end


  describe "#plant_mine" do

    it "toggles square to become a mine" do
      s = Square.new(1,3)
      expect(s.plant_mine).to be_truthy
    end

  end


  describe "#status" do
    let(:s) { Square.new(3, 5) }

    it "displays O for an uncleared square" do
      expect(s.status).to eq("O")
    end

    it "displays @ for a flagged square" do
      s.flag
      expect(s.status).to eq("@")
    end

    it "displays _ for a cleared square" do
      s.clear
      expect(s.status).to eq("_")
    end

    it "displays Number for clue square"

  end

end
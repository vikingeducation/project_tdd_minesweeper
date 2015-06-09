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
    let(:s) { Square.new(1,3) }

    it "toggles square to become a mine" do
      expect(s.plant_mine).to be_truthy
    end

  end


  describe "#status" do
    let(:s) { Square.new(3, 5) }

    before do
      s.nearby_count = 0
      allow(@board).to receive(:autoclear).and_return(true)
    end

    it "displays O for an uncleared square" do
      expect(s.status).to eq("#")
    end

    it "displays @ for a flagged square" do
      s.flag
      expect(s.status).to eq("X".colorize(:cyan))
    end

    it "displays _ for a cleared square" do
      s.clear
      expect(s.status).to eq(" ")
    end

    it "displays Number for clue square" do
      s.nearby_count = 3
      s.clear
      expect(s.status).to eq(3)
    end

  end


  describe "#clear" do
    let(:s) { Square.new(3, 5) }

    it "clears the square if it's currently uncleared" do
      expect{s.clear}.to change{s.cleared}.from(false).to(true)
    end

    it "stays cleared if already has been cleared" do
      s.clear
      expect{s.clear}.not_to change{s.cleared}
    end

    it "explodes if it's a mine" do
      s.plant_mine
      expect{s.clear}.to change{s.status}.to("*".colorize(:red))
    end

  end


  describe "#flag" do
    let(:s) { Square.new(3, 5) }

    it "flags the square if it's currently unflagged" do
      expect{s.flag}.to change{s.flagged}.from(false).to(true)
    end

    it "unflags the square if it's currently flagged" do
      s.flag
      expect{s.unflag}.to change{s.flagged}.from(true).to(false)
    end

  end

end
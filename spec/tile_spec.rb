require_relative "../lib/tile.rb"

describe Tile do

  let(:t) {Tile.new(0,5)}

  describe "#initialize" do

    it "is an instance of the Tile class" do

      expect(t).to be_a(Tile)

    end

  end

  context "reponds to different method calls" do

    it "sets the mines nearby" do

      t.mines_nearby = 4
      expect(t.mines_nearby).to eq(4)

    end

    it "it changes the is_cleared variable" do

      expect(t).to respond_to(:is_cleared=)

    end

  end


end
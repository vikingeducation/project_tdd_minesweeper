require 'board'

describe Board do

  describe "#initialize" do

    it "should create a Board object" do

      expect(Board.new).to be_a(Board)

    end

    it "should be 10x10 by default" do

      expect(Board.new.flatten.size).to eq(100)

    end

    it "should have 9 mines by default"

  end

  describe "game play" do

    it "should show remaining flags"

  end

end
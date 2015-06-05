require 'minesweeper'
require 'pry'

describe Minesweeper do

  describe "#initialize" do

    it "creates a board with set height & width" do
      expect(Board).to receive(:new).with(10, 10, 9)
      Minesweeper.new
    end

    it "creates a player" do
      expect(Player).to receive(:new).with(10, 10)
      Minesweeper.new
    end

  end

end
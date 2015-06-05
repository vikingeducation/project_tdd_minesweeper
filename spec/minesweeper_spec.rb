require 'minesweeper'
require 'pry'

describe Minesweeper do

  describe "#initialize" do

    it "creates a board with set height & width" do
      expect(Board).to receive(:new).with(10, 10, 9)
      Minesweeper.new(10, 10, 9)
    end

  end

end
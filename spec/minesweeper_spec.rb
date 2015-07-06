require_relative '../lib/minesweeper.rb'
require_relative '../lib/tile.rb'

describe Minesweeper do

  describe "#initialize" do

    it "is an instance of minesweeper class" do

      expect(subject).to be_a(Minesweeper)

    end

  end

  describe "#player_win?" do

    let(:my_tile) {Tile.new(1,1)}

    it "should return true if you win" do

      my_tile.is_cleared = true
      my_board = instance_double("Board", :game_state => Array.new(10) {Array.new(10, my_tile)}
      subject.instance_variable_set(:@board, my_board)

      # allow(subject).to receive(:game_state).and_return(my_board)
      expect(subject.player_win?).to be true

    end

  end


end
require_relative '../lib/minesweeper.rb'
require_relative '../lib/tile.rb'

describe Minesweeper do

  describe "#initialize" do

    it "is an instance of minesweeper class" do

      expect(subject).to be_a(Minesweeper)

    end

  end

  describe "#play" do

    before do
      my_board = instance_double("Board", :render => nil)
      my_player = instance_double("Player", :get_move => Tile.new(0,0))
      subject.instance_variable_set(:@board, my_board)
      subject.instance_variable_set(:@player, my_player)
    end

    it "calls the #print_instructions method" do

      expect(subject).to receive(:print_instructions)
      allow(subject).to receive(:render)
      allow(subject).to receive(:get_move)
      subject.play

    end

    it "loops until game over is true" do
      # allow(subject).to receive(:player_win?).and_return(true)

    end

    specify "player.get_move return an instance of a tile" do


    end




  end

  describe "#game_over?" do

    let(:my_tile) {Tile.new(1,1)}

    it "calls the #player_win? method" do

      allow(subject).to receive(:player_win?).and_return(true)

      expect(subject.game_over?(my_tile)).to be true

    end

  end

  describe "#player_win?" do

    let(:my_tile) {Tile.new(1,1)}
    let(:my_mine_tile) {Tile.new(1,1)}

    it "should return true if all board is clear" do

      my_tile.is_cleared = true
      my_board = instance_double("Board", :game_state => Array.new(10) {Array.new(10, my_tile)})
      subject.instance_variable_set(:@board, my_board)
      expect(subject.player_win?).to be true

    end

    it "should return true if you clear all the tiles except the mines" do

      my_tile.is_cleared = true
      my_mine_tile.is_mine = true
      initial_board = Array.new(10) {Array.new(10, my_tile)}
      initial_board[5][3] = my_mine_tile
      my_board = instance_double("Board", :game_state => initial_board)
      subject.instance_variable_set(:@board, my_board)
      expect(subject.player_win?).to be true

    end

  end


end
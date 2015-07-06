require_relative '../lib/minesweeper.rb'
require_relative '../lib/tile.rb'

describe Minesweeper do

  describe "#initialize" do

    it "is an instance of minesweeper class" do

      expect(subject).to be_a(Minesweeper)

    end

  end

  describe "#play" do

    let(:my_board) { double("Board", :render => nil) }
    let(:my_player) { double("Player", :get_move => nil) }

    before do
      subject.instance_variable_set(:@board, my_board)
      subject.instance_variable_set(:@player, my_player)
    end

    it "calls the #print_instructions method" do

      expect(subject).to receive(:print_instructions)
      allow(my_board).to receive(:render)
      allow(my_player).to receive(:get_move)
      allow(subject).to receive(:game_over?).with(any_args).and_return(true)
      subject.play

    end

    it "loops until game over is true" do

      allow(subject).to receive(:game_over?).and_return(false, false, false, true)
      allow(subject).to receive(:print_instructions)
      allow(my_board).to receive(:render)
      expect(my_player).to receive(:get_move).exactly(4).times
      subject.play

    end

    # specify "player.get_move return an instance of a tile" do

    #   allow(subject).to receive(:print_instructions)
    #   allow(my_board).to receive(:render)
    #   allow(subject).to receive(:game_over?).with(any_args).and_return(true)

    # end


  end

  describe "#game_over?" do

    let(:my_tile) {Tile.new(1,1)}

    it "returns true if a player wins" do

      allow(subject).to receive(:player_win?).and_return(true)

      expect(subject.game_over?(my_tile)).to be true

    end

    it "returns true if we clear a mine tile" do

      allow(subject).to receive(:hit_mine?).and_return(true)

      expect(subject.game_over?(my_tile)).to be true

    end

  end

  context "check methods that call board" do

    let(:my_tile) {Tile.new(1,1)}
    let(:my_mine_tile) {Tile.new(1,1)}
    let(:my_board) { instance_double("Board", :game_state => Array.new(10) {Array.new(10, my_tile)}) }

    before do
        subject.instance_variable_set(:@board, my_board)
    end

    describe "#player_win?" do

      it "returns true if all board is clear" do

        my_tile.is_cleared = true
        expect(subject.player_win?).to be true

      end

      it "returns true if you clear all the tiles except the mines" do

        my_tile.is_cleared = true
        my_mine_tile.is_mine = true
        initial_board = Array.new(10) {Array.new(10, my_tile)}
        initial_board[5][3] = my_mine_tile
        expect(subject.player_win?).to be true

      end

      it "returns false if all the board is not clear" do

        expect(subject.player_win?).to be false

      end

      it "returns false if board has one uncleared tile (apart from mines)" do

        my_tile.is_cleared = true
        my_mine_tile.is_mine = true

        initial_board = Array.new(10) {Array.new(10, my_tile)}
        initial_board[5][3] = my_mine_tile
        initial_board[4][4].is_cleared = false

        expect(subject.player_win?).to be false

      end

    end

    describe "#hit mine?" do

      it "returns true if a mine has been cleared" do

        my_mine_tile.is_mine = true
        my_mine_tile.is_cleared = true

        allow(my_board).to receive(:reveal_mines)

        expect(subject.hit_mine?(my_mine_tile)).to be true

      end

      it "returns false if with a cleared regular tile" do 
         
         my_tile.is_cleared = true
         allow(my_board).to receive(:reveal_mines)

        expect(subject.hit_mine?(my_tile)).to be false

      end

      it "returns false if a the tile is uncleared" do

        allow(my_board).to receive(:reveal_mines)

        expect(subject.hit_mine?(my_tile)).to be false

      end


    end


  end


end
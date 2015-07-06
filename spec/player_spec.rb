
require_relative '../lib/player.rb'
require_relative '../lib/board.rb'
require_relative '../lib/tile.rb'


describe Player do


  let (:p) {Player.new(Board.new)}

  describe "#initialize" do

    it "is a player" do

      expect(p).to be_a(Player)

    end

  end

  describe "#get_move" do

    it "returns a Tile" do

      allow(p).to receive(:get_move_type).and_return("c")
      allow(p).to receive(:get_coordinates).and_return([1,1])
      expect(p.get_move).to be_a(Tile)

    end

    it "calls get_move_type" do

      expect(p).to receive(:get_move_type)
      allow(p).to receive(:get_coordinates)
      allow(p).to receive(:perform_move).with(any_args)
      p.get_move

    end

    it "calls #get_coordinates method" do

      expect(p).to receive(:get_coordinates)
      allow(p).to receive(:get_move_type)
      allow(p).to receive(:perform_move).with(any_args)
      p.get_move

    end

  end

  describe "#perform_move" do

    let(:my_tile) {Tile.new(4,5)}
    let(:my_board) { double("a_board")}

    it "clears a tile if not already cleared" do

      p.instance_variable_set(:@board, my_board)

      allow(my_board).to receive(:game_state).and_return([[my_tile]])
      allow(my_board).to receive(:clear_nearby)
      p.perform_move("c",[0,0])
      expect(my_tile.is_cleared).to be true

    end

    it "doesn't clear a tile if already cleared" do

      p.perform_move("c",[0,0])

      expect{p.perform_move("c",[0,0])}.to output("You already cleared this tile\n").to_stdout

    end

  end





end

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

      expect(p.get_move).to be_a(Tile)

    end

    # it "calls get_move_type"


  end





end
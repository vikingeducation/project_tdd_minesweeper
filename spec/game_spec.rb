require 'tile'
require 'board'
require 'game'

describe Game do
  let(:game) { Game.new }

  context "#initialize" do
    it "creates a new game" do
      expect(game).to be_a(Game)
    end

    it "creates a new board" do
      expect(game.board).to be_a(Board)
    end

    it "creates 9 flags" do
      expect(game.flags).to eq(9)
    end

    it "sets no_explosions to true" do
      expect(game.no_explosions).to be(true)
    end
  end

  context "handling input" do
    let(:tile) { Tile.new(1,2) }

    it "gets inputs from user" do
      allow(game).to receive(:gets).and_return("1 2")
      expect(game).to receive(:process_input).with("1 2")
      game.get_coordinates
    end

    it "processes input afterwards" do
      expect(game).to receive(:make_move).with(1,2,nil)
      game.process_input("1 2")
    end

    it "checks for mine if no flag was placed" do
      expect(game).to receive(:check_for_mine).with(1,2)
      game.make_move(1,2,nil)
    end
  end
end

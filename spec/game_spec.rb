require 'game'

describe "Game" do

  let(:game){Game.new}

  describe "#intialize" do

    it "initializes a game" do
      expect(Game.new).to be_a(Game)
    end

  end

  describe "#play" do

    it "receives the game loop" do
      expect(game).to receive(:game_loop)
      game.play
    end

  end
end
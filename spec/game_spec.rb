require 'game'

describe "Game" do

  let(:game){Game.new}

  describe "#intialize" do

    it "initializes a game" do
      expect(Game.new).to be_a(Game)
    end

  end

  describe "#play" do
    it "receives the setup" do
      expect(game).to receive(:setup)
      game.play
    end

    it "receives the game loop" do
      expect(game).to receive(:game_loop)
      game.play
    end
  end

  describe '#game_loop' do
    it "should receive get_input" do
      expect(game).to receive(:get_input)
      game.game_loop
    end
    it "should receive make_move"
  end

  describe '#get_input' do
    it "can receive get_input and return a value" do
      expect(game).to receive(:get_input).and_return([1,2])
      game.get_input
    end
  end
end

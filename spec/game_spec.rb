require 'game'

describe "Game" do

  let(:game){ Game.new }
  let(:board){ double("board", move: true) }

  describe "#intialize" do
    it "initializes a game" do
      expect(Game.new).to be_a(Game)
    end
  end

  describe "#play" do
    it "receives the render" do
      allow(game).to receive(:game_loop)
      expect(game).to receive(:render)
      game.play
    end

    it "receives the game loop" do
      expect(game).to receive(:game_loop)
      game.play
    end
  end

  describe '#game_loop' do
    it "should receive make_move" do
      allow(game).to receive(:get_input)
      expect(game).to receive(:make_move)
      game.game_loop
    end

    it "should receive get_input" do
      allow(game).to receive(:make_move)
      expect(game).to receive(:get_input)
      game.game_loop
    end

    it "should receive game_over?" do
      allow(game).to receive(:get_input)
      allow(game).to receive(:make_move)
      expect(game).to receive(:game_over?)
      game.game_loop
    end

    it "should receive render" do
      allow(game).to receive(:get_input).and_return([1,2])
      allow(game).to receive(:make_move)
      expect(game).to receive(:render)
      game.game_loop
    end
  end
end

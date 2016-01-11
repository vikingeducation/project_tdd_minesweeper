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
      allow(game).to receive(:game_loop)
      expect(game).to receive(:setup)
      game.play
    end

    it "receives the game loop" do
      allow(game).to receive(:setup)
      expect(game).to receive(:game_loop)
      game.play
    end
  end

  describe '#game_loop' do

    it "should receive get_input" do
      expect(game).to receive(:get_input)
      game.game_loop
    end

    it "should receive make_move" do
      allow(game).to receive(:get_input)
      expect(game).to receive(:make_move)
      game.game_loop
    end

  end

  describe '#get_input' do
    
  end
end

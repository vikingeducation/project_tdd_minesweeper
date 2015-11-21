require_relative '../lib/game.rb'

describe Game do

  let(:game){ Game.new(10, 9, 'Name') }

  describe '#initialize' do

    it 'should be a Game' do
      expect(game).to be_a(Game)
    end

    it 'should create a Board' do
      expect(game.board).to be_a(Board)
    end

    it 'should create a Player' do
      expect(game.player).to be_a(Player)
    end
  end

  describe '#play' do

    it 'should have the player to take a turn' do
      allow(game.player).to receive(:take_turn).and_return(true)
      expect(game.player).to receive(:take_turn)
      game.play
    end
  end

end
require_relative '../lib/game.rb'
require_relative '../lib/board.rb'

describe Game do

  let(:board){ Board.new }
  let(:game){ Game.new(10, 9, 'Name', board) }

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
      allow(game.player).to receive(:take_turn).and_return(true, true)
      allow(game).to receive(:game_over?).and_return(false, true)

      expect(game.player).to receive(:take_turn)
      game.play
    end

    it 'should play until game is over' do
      allow(game.player).to receive(:take_turn).and_return(true, true)
      allow(game).to receive(:game_over?).and_return(false, true)
      expect(game).to receive(:game_over?).and_return(false)
      expect(game).to receive(:game_over?).and_return(true)
      game.play
    end

    it 'should render the board between turns' do
      allow(game.player).to receive(:take_turn).and_return(true, true)
      allow(game).to receive(:game_over?).and_return(false, true)

      expect(board).to receive(:render)
      expect(board).to receive(:render)
      game.play
    end
  end

end
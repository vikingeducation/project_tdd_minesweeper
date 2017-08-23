RSpec.describe Minesweeper::Game do
  let(:game) { Minesweeper::Game.new }

  describe '#initialize' do
    it 'has a default Renderer and Board' do
      expect(game.board).to be_a Minesweeper::Board
      expect(game.renderer).to be_a Minesweeper::Renderer
    end
  end

  describe '#start' do
    it 'displays intro' do
      allow(game).to receive(:over?).and_return(true)
      expect(game).to receive(:display_intro)
      game.start
    end

    it 'initially renders board in :prestart mode' do
      renderer = double('Renderer')
      board = double('Board', all_cleared?: false)
      game = Minesweeper::Game.new(renderer: renderer, board: board)
      allow(game).to receive(:over?).and_return(true)
      expect(renderer).to receive(:render).with(board, :over).once
      game.start
    end
  end
end

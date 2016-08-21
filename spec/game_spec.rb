require 'minesweeper'


describe Minesweeper::Game do

  before do
    allow($stdout).to receive(:puts)
  end

  let(:board){Minesweeper::Board.new(5, 5, nil, [[0,0],[1,1],[2,2],[3,3],[4,4]])}
  let(:game){Minesweeper::Game.new(board)}

  describe '#initialize' do
    it 'initializes a new game' do
      expect(game).to be_a(Minesweeper::Game)
    end
  end

  describe '#run' do
    it 'calls welcome message on view' do
      allow(game).to receive(:finish?).and_return(true)
      expect(game.view).to receive(:welcome_message).and_return("welcome!")
      game.run
    end
  end

end

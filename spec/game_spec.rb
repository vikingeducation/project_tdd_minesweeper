require 'game'

describe Game do
  before(:each) do
    allow( game ).to receive( :puts ).and_return( nil )
  end

  let(:game) { Game.new }

  describe '#play' do
    it 'initiates a new Game' do
    end
    it 'gets input from the user'
    describe 'ends the game when' do
      it 'a mine has been selected'
      it 'all mines have flags on them'
      it 'all non-mine cells have been cleared'
    end
  end

  describe '#exit_game' do
    xit 'exits the game' do
      allow(game).to receive(:gets).and_return('n')
      allow(game).to receive(:exit_game).and_return("-stubbed-")
      expect(game).to receive(:exit_game).and_return("-stubbed-")
      game.play
    end
  end
end

require 'minesweeper'

describe Minesweeper do
  let(:board){double("board", :render => true, :win? => true)}
  let(:player){double("player", :turn => true, :lose? => true)}
  let(:game){Minesweeper.new}

  it 'is an instance of class' do
    expect(subject).to be_a(Minesweeper)
  end

# Q for Erik, this bit doesn't make any sense to me, false passes happening
  describe '#start_game' do
=begin
    it 'calls the board #render method' do
      expect(board).to receive(:render)
      game.start_game
    end

    it 'calls the player #turn method' do
      expect(player).to receive(:turn)
      game.start_game
    end
=end


  end
end
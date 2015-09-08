require 'game'

describe Game do

  let(:g){Game.new}

  describe '#initialize' do
  end

  # describe '#play' do
  #   # how to prevent infinite loop
  #   it 'goes through the play loop' do 
  #     expect(g).to receive(:puts)

  #     allow(g).to receive(:prompt_move)
  #     allow(g).to receive(:execute_move)

  #     # how do I do this?
  #     #allow(g).to receive(:board.loss)
  #     g.play
  #   end
  # end

  describe '#flag_move?' do
    it 'returns true if "y" is passed' do
      allow(g).to receive(:gets).and_return("y")

      expect(g.flag_move?).to be_truthy
    end
  end

  describe '#prompt_move' do
    it 'receives a coordinate in the form of [x,y]' do
      allow(g).to receive(:gets).and_return("1,2")

      expect(g.prompt_move).to eq([1,2])
    end
  end
end
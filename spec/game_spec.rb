require 'rspec'
require 'game'

describe Game do
  g = Game.new
  describe "initialize" do
    it 'creates a board' do
      expect(g.board).to be_a(Board)
    end
    it 'does other stuff'
  end

  describe 'play' do
    it 'calls'
  end

  describe 'get_move' do
    it 'returns an array containing coordinates and commands' do
      allow(g).to receive(:gets).and_return("big boobs")
      expect(g.get_move).to eq([0,0,"c"])
    end
    it 'calls evaluate_move' do
      allow(g).to receive(:gets).and_return("big boobs")
      expect(g).to receive(:evaluate_move)
      g.get_move
    end
    it 'returns error if input in incorrect format'


  end

  describe 'valid_move' do
    it 'returns true if input in correct format' do
      expect(g.valid_move("1,1,c")).to eq(true)
    end

    it 'returns false if input does not conform' do
      expect(g.valid_move("test")).to eq(false)
    end

    it 'is false if selection outside of the board' do
      expect(g.valid_move("11,-1,f")).to eq(false)
    end
  end



end

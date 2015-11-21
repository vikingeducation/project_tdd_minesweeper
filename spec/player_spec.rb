require_relative '../lib/player.rb'
require_relative '../lib/board.rb'

describe Player do

  let(:board){ Board.new(5,5,[
      [0,1,0,0,1],
      [1,1,0,0,0],
      [0,0,0,0,0],
      [0,0,0,1,0],
      [0,0,0,0,0]
    ]) }
  let(:player){ Player.new(board, "Name") }

  describe '#initialize' do

    it 'should be a Player' do
      expect(player).to be_a(Player)
    end

    it 'should have a name' do
      expect(player.name).to eq("Name")
    end

    it 'should have a board' do
      expect(player.board).to be_a(Board)
    end
  end

  describe '#take_turn' do

    it 'should ask for a move type' do
      allow(player).to receive(:ask_move_type).and_return('c')
      allow(player).to receive(:ask_turn).and_return([1,1])
      expect(player).to receive(:ask_move_type)
      player.take_turn
    end

    context 'place a flag' do
      it 'should ask the player for a flag location'
      it 'should ask again if the entry is not valid'
      it 'should allow the player to place a flag on the board'
      it 'should ask again if the flag location was not valid'

    end

    context 'clear a square' do

      it 'should ask the player for a move' do
        allow(player).to receive(:ask_move_type).and_return('c')
        allow(player).to receive(:ask_turn).and_return([1,1])
        expect(player).to receive(:ask_turn)
        player.take_turn
      end

      it 'should ask again if the entry is not valid' do
        allow(player).to receive(:ask_move_type).and_return('c')
        allow(player).to receive(:ask_turn).and_return([0], [1,1])
        expect(player).to receive(:ask_turn)
        expect(player).to receive(:ask_turn)
        player.take_turn
      end

      it 'should allow the player to place a move on board' do
        allow(player).to receive(:ask_move_type).and_return('c')
        allow(player).to receive(:ask_turn).and_return([1,1])
        allow(board).to receive(:place_move).and_return(true)
        expect(board).to receive(:place_move)
        player.take_turn
      end

      it 'should ask again if the move location was not valid' do
        allow(player).to receive(:ask_move_type).and_return('c')
        allow(player).to receive(:ask_turn).and_return([20,1], [0,1])
        allow(board).to receive(:place_move).and_return(false, true)

        expect(player).to receive(:ask_turn)
        expect(board).to receive(:place_move)

        expect(player).to receive(:ask_turn)
        expect(board).to receive(:place_move)

        player.take_turn
      end
    end
  end
end
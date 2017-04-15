RSpec.describe MineSweeper do
  let(:ui_spy) { spy('Game UI') }
  let(:board_spy) { spy('Game board') }
  let(:minesweeper) { MineSweeper.new(ui: ui_spy, board: board_spy) }

  describe 'prompting user for a move' do
    context 'valid move/action' do
      before do
        allow(board_spy).to receive(:valid_move?) { true }
        minesweeper.play
      end

      it 'checks if cell is available' do
        expect(ui_spy).to have_received(:get_cell_choice)
      end

      it 'prompts user for action on that cell' do
        expect(ui_spy).to have_received(:get_cell_action)
      end

      it 'runs action on the cell' do
        expect(board_spy).to have_received(:make_move)
      end
    end

    context 'invalid move' do
      it 'displays feedback and prompts player for move' do
        allow(board_spy).to receive(:valid_move?).and_return(false, true)

        minesweeper.play

        expect(ui_spy).to have_received(:invalid_move)
        expect(ui_spy).to have_received(:get_cell_choice).twice
      end
    end

    context 'invalid action on cell' do
      it 'displays feedback and prompts player for action' do
        allow(board_spy).to receive(:valid_move?) { true }
        allow(board_spy).to receive(:valid_action?).and_return(false, true)

        minesweeper.play

        expect(ui_spy).to have_received(:invalid_action)
        expect(ui_spy).to have_received(:get_cell_action).twice
      end
    end
  end
end

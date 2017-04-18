RSpec.describe MineSweeper do
  let(:ui_spy) { spy('Game UI') }
  let(:board_spy) { spy('Game board') }
  let(:minesweeper) { MineSweeper.new(ui: ui_spy, board: board_spy) }

  describe 'prompting user for a move' do
    before { allow(minesweeper).to receive(:game_over?).and_return(false, true) }

    context 'valid move/action' do
      before do
        allow(minesweeper).to receive(:validate_move)
        allow(minesweeper).to receive(:validate_action)
        allow(minesweeper).to receive(:make_move)

        minesweeper.play
      end

      it 'displays the board' do
        expect(minesweeper).to have_received(:make_move)
        expect(ui_spy).to have_received(:display_board).with board_spy
      end

      it 'makes the move' do
        expect(ui_spy).to have_received(:get_cell_choice)
      end

      it 'prompts user for action on that cell' do
        expect(ui_spy).to have_received(:get_cell_action)
      end
    end

    context 'invalid move' do
      it 'prompts player for move again' do
        allow(board_spy).to receive(:valid_move?).and_return(false, true)
        allow(ui_spy).to receive(:get_cell_action).and_return('C', 'c')

        minesweeper.play

        expect(ui_spy).to have_received(:get_cell_choice).twice
      end
    end

    context 'invalid action on cell' do
      it 'prompts player for action again' do
        allow(board_spy).to receive(:valid_move?) { true }
        allow(ui_spy).to receive(:get_cell_action).and_return('derp', 'c')

        minesweeper.play
        expect(ui_spy).to have_received(:get_cell_action).twice
      end
    end
  end

  describe 'ending the game' do
    context 'when a mined cell is cleared' do
      it 'ends the game' do
        allow(minesweeper).to receive(:validate_action)
        allow(board_spy)
          .to receive(:record_move)
                .and_raise Errors::CellWasMinedError, 'You found a mine!'

        expect { minesweeper.play }
          .to output("\nYou found a mine!\n")
                .to_stdout
      end
    end
  end
end

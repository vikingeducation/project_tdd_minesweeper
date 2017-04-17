RSpec.describe MineSweeper do
  let(:ui_spy) { spy('Game UI') }
  let(:board_spy) { spy('Game board') }
  let(:minesweeper) { MineSweeper.new(ui: ui_spy, board: board_spy) }

  describe 'prompting user for a move' do
    context 'valid move/action' do
      before do
        allow(board_spy).to receive(:valid_move?) { true }
        allow(minesweeper).to receive(:make_move)
        minesweeper.play
        expect(minesweeper).to have_received(:make_move)
      end

      it 'displays the board' do
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
      it 'displays feedback and prompts player for move' do
        allow(board_spy).to receive(:valid_move?).and_return(false, true)
        allow(ui_spy).to receive(:get_cell_action).and_return('C', 'c')

        expect { minesweeper.play }
          .to output("Those coordinates are incorrect. Start again.\n")
                .to_stdout
        expect(ui_spy).to have_received(:get_cell_choice).twice
      end
    end

    context 'invalid action on cell' do
      it 'displays feedback and prompts player for action' do
        allow(board_spy).to receive(:valid_move?) { true }
        allow(ui_spy).to receive(:get_cell_action).and_return('derp', 'c')

        expect { minesweeper.play }
          .to output("That action is illegal. Start again.\n")
                .to_stdout

        expect(ui_spy).to have_received(:get_cell_action).twice
      end
    end
  end
end

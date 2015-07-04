require_relative '../lib/board.rb'

describe Board do
	let(:board){Board.new}

	describe '#initialize' do
		it 'should be 10 by 10 by default' do
			expect(board.game_board.flatten.size).to eq(100)
		end

		it 'should have 9 mines by default' do
			expect(board.mines).to eq(9)
		end

		it 'should show remaining flags' do
			expect(board.show_remaining_flags).to eq(9)
		end
	end

	describe '#change_state_of_square' do
		it 'player can change the state of a square' do
			board.change_state_of_square(5)
			expect(board.game_board[5].state).to eq(1)
		end

		specify 'a state of the square should be cleared' do   #this is similar to, the board has two states
			condition1 = board.game_board[3].state
			board.change_state_of_square(3)
			condition2 = board.game_board[3].state
			expect(condition1).not_to eql(condition2)
		end
	end

	specify 'on selection the square should appear as cleared in the render' do
		condition1 = board.render
		board.change_state_of_square(1)
		condition2 = board.render
		expect(condition2 - condition1).to eq(1)
	end

end
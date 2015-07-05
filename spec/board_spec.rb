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

context "tests that need a cell without a mine" do
	before (:each) do
		@square = board.game_board.sample
		while (@square.mine == 1)
			@square = board.game_board.sample
		end
	end

	describe '#change_state_of_square' do
		it 'player can change the state of a square' do
			board.change_state_of_square(@square.position_in_grid.to_i)
			expect(board.game_board[@square.position_in_grid.to_i].state).to eq(1)   #Q: how can I write this to avoid mines?
		end

		specify 'a square can be cleared' do   #this is similar to, the board has two states
			condition1 = board.game_board[@square.position_in_grid.to_i].state
			board.change_state_of_square(@square.position_in_grid.to_i)
			condition2 = board.game_board[@square.position_in_grid.to_i].state
			expect(condition1).not_to eql(condition2)
		end
	end

	specify 'on selection the square should appear as cleared in the render' do
		condition1 = board.render_grid  #Q:how do I stop the board from actually rendering in the test loop
		board.change_state_of_square(@square.position_in_grid.to_i)
		condition2 = board.render_grid
		expect(condition2 - condition1).to eq(1)
	end

end

	it "should end game if player selects a square with a mine in it" do
		board.game_board[1].set_mine
		expect(board.change_state_of_square(1)).to be_nil
	end

end